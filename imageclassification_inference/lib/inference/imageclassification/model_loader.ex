defmodule Inference.ImageClassification.ModelLoader do
  @moduledoc """
  Preparing a function that receives three paths and loads the necessary information from them.

  - Args
    graph_path: Pb file with trained model
    label_path: Txt file with class index and name
    io_json_path: Json file with information about input and output
  """

  @doc """
  Returning the loaded information as an array.
  This array is split in that order depending on whether it is used for
  ImageLoader.load_image() or ExecuteInference.inferece().

  ## Example
      iex(1)> Inference.ImageClassification.ModelLoader.load_model([
        "path/to/graph",
        "path/to/labels",
        "path/to/io_json"
      ])
      :ok
  """
  @spec load_model([String.t()]) :: [[any()]]
  def load_model([graph_path, label_path, io_json_path]) do
    graph =
      graph_path
      |> Extensor.Session.load_frozen_graph!()

    column_list =
      label_path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)

    io_infos =
      io_json_path
      |> File.read!()
      |> Poison.decode!()

    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)

    [[input_info, input_height, input_width], [graph, output_info, column_list]]
  end
end
