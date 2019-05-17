defmodule LoadPreTrainedModel do
  alias Extensor, as: Et

  defp load_label(label_file_path) do
    file = File.read!(label_file_path)
    _list = String.split(file, "\n") |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)
  end

  defp load_io_json(io_json_path) do
    io_infos = io_json_path |> File.read!() |> Poison.decode!()
    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)
    [input_info, output_info, input_height, input_width]
  end

  defp load_graph(model_path) do
    _graph = Et.Session.load_frozen_graph!(model_path)
  end

  def load_prepare_file do
    label_file_path = "./labels.txt"
    io_json_path = "./pre_trained_model/io.json"
    model_path = "./pre_trained_model/model.pb"
    [load_label(label_file_path), load_io_json(io_json_path), load_graph(model_path)]
  end
end
