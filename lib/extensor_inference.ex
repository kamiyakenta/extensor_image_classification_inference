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
    input = Enum.at(io_infos["input"], 0)
    output = Enum.at(io_infos["output"], 0)
    resize_height = Enum.at(io_infos["inputShape"], 1)
    resize_width = Enum.at(io_infos["inputShape"], 2)
    output_size = Enum.at(io_infos["outputShape"], 1)

    # model(graph)の準備

    # input(image)の準備
    Mf.open(image_path) |> Mf.resize("#{resize_height}x#{resize_width}") |> Mf.save(in_place: true)


    # outputの準備

    # 実行


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
