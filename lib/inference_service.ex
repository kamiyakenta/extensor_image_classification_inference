defmodule InferenceService do
  alias Extensor, as: Et
  alias Mogrify, as: Mf
  alias Imagineer, as: Im

  defstruct [:graph, :label, :io_info]

  defp convert_image(image_path) do
    img_ext = Path.extname(image_path)
    if img_ext == ".png" do
      image_path
    else
      png_image = Mf.open(image_path) |> Mf.format("png") |> Mf.save
      png_image.path
    end
  end

  def load_model(%InferenceService{graph: model_path, label: label_path, io_info: io_json_path}) do
    # graphの読み込み
    graph = Et.Session.load_frozen_graph!(model_path)

    # labelの読み込み
    file = File.read!(label_path)
    column_list = String.split(file, "\n") |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)

    # io_infoの読み込み
    io_infos = io_json_path |> File.read!() |> Poison.decode!()
    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)
    io_infos = [input_info, output_info, input_height, input_width]

    # return
    %InferenceService{graph: graph, label: column_list, io_info: io_infos}
  end

  def load_image(pre_trained_model, image_path) do
    # 準備
    input_info = Enum.at(pre_trained_model.io_info, 0)
    input_height = Enum.at(pre_trained_model.io_info, 2)
    input_width = Enum.at(pre_trained_model.io_info, 3)

    # 実行
    Mf.open(image_path) |> Mf.resize_to_fill("#{input_height}x#{input_width}") |> Mf.save(in_place: true)
    {:ok, image} = Im.load(convert_image(image_path))
    normalized_image_list = for image_pixels_width <- image.pixels, do: Enum.map(image_pixels_width, fn(pixel) -> Tuple.to_list(pixel) |> Enum.map(fn(x) -> x/255 end) end)
    image_pixels = [normalized_image_list]
    %{ input_info => Et.Tensor.from_list(image_pixels) }
  end

  def inference(pre_trained_model, input_tensor) do
    # 準備
    graph = pre_trained_model.graph
    output_info = Enum.at(pre_trained_model.io_info, 1)
    column_list = pre_trained_model.label

    # 実行
    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])
    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])
    prob_list = List.flatten(prob_tensor_results)
    max_prob = Enum.max(prob_list)
    List.zip([column_list, prob_list]) |> Enum.map(fn({column, prob}) -> if prob == max_prob, do: IO.puts "#{column}   #{prob}\n" end )
  end
end
