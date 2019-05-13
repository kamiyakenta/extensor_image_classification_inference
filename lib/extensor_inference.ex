defmodule ExtensorInference do
  alias Extensor, as: Et
  alias Mogrify, as: Mf

  def load_label(label_file_path) do
    file = File.read!(label_file_path)
    list = String.split(file, "\n") |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)
    list
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

    # input(image)の準備  (shape: {1, 256, 256, 3}, type: :floatにする)
    Mf.open(image_path) |> Mf.resize("#{input_height}x#{input_width}") |> Mf.save(in_place: true)
    list2d = for _n <- 1..256, do: [0.80, 0.45, 0.34]
    list3d = for _n <- 1..256, do: list2d
    list4d = [list3d]
    input_tensor = %{
      input_info => Et.Tensor.from_list(list4d)
    }
    # {:ok, image} = File.read(image_path)
    # input_tensor = %{
    #   input_info => %Extensor.Tensor{
    #     data: image,
    #     shape: {1, 256, 256, 3},
    #     type: :float
    #   }
    # }

    # 実行
    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])

    # outputの準備
    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])

    # 結果のファイル出力
    column_list = load_label(label_file_path)
    prob_list = List.flatten(prob_tensor_results)
    results = List.zip([column_list, prob_list]) |> Enum.map(fn({column, prob}) -> "#{column}   #{prob}\n" end )
    File.write(output_path, results)
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
