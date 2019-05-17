defmodule ExtensorInference do
  alias Extensor, as: Et
  alias Mogrify, as: Mf
  alias Imagineer, as: Im
  # import InferenceServer, only: [run_inference_server: 1]

  def load_label(label_file_path) do
    file = File.read!(label_file_path)
    _list = String.split(file, "\n") |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)
  end

  def convert_image(image_path) do
    img_ext = Path.extname(image_path)
    if img_ext == ".png" do
      image_path
    else
      png_image = Mf.open(image_path) |> Mf.format("png") |> Mf.save
      png_image.path
    end
  end

  def inference(model_path, label_file_path, image_path, output_path) do

    # io.jsonの読み込み
    io_json_path = "./pre_trained_model/io.json"
    io_infos = io_json_path |> File.read!() |> Poison.decode!()
    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)

    # model(graph)の準備
    graph = Et.Session.load_frozen_graph!(model_path)

    # input(image)の準備  (shape: {1, 256, 256, 3}, type: :float)
    Mf.open(image_path) |> Mf.resize_to_fill("#{input_height}x#{input_width}") |> Mf.save(in_place: true)
    {:ok, image} = Im.load(convert_image(image_path))
    normalized_image_list = for image_pixels_width <- image.pixels, do: Enum.map(image_pixels_width, fn(pixel) -> Tuple.to_list(pixel) |> Enum.map(fn(x) -> x/255 end) end)
    image_pixels = [normalized_image_list]
    input_tensor = %{
      input_info => Et.Tensor.from_list(image_pixels)
    }

    # 実行
    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])

    # outputの準備
    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])

    # 結果のファイル出力
    column_list = load_label(label_file_path)
    prob_list = List.flatten(prob_tensor_results)
    results = List.zip([column_list, prob_list]) |> Enum.map(fn({column, prob}) -> "#{column}   #{prob}\n" end )
    File.write(output_path, results)
    max_prob = Enum.max(prob_list)
    List.zip([column_list, prob_list]) |> Enum.map(fn({column, prob}) -> if prob == max_prob, do: IO.puts "#{column}   #{prob}\n" end )
  end

  def execute_inference do
    model_path = "./pre_trained_model/model.pb"
    label_file_path = "./labels.txt"
    image_path = "./images/image.jpg"
    output_path = "./output.txt"
    inference(model_path, label_file_path, image_path, output_path)
  end
end

ExtensorInference.execute_inference
