defmodule Inference.ImageClassification.ModelLoaderTest do
  use ExUnit.Case, async: true
  alias Inference.ImageClassification.ModelLoader

  setup do
    model_dir = Path.join(["test", "inference", "imageclassification", "model"])
    {:ok, model_dir: model_dir}
  end

  test "load_model", state do
    [[input_info, input_height, input_width], [graph, output_info, column_list]] =
      ModelLoader.load_model([
        Path.join([state[:model_dir], "model.pb"]),
        Path.join([state[:model_dir], "labels.txt"]),
        Path.join([state[:model_dir], "io.json"])
      ])

    assert input_info |> is_bitstring()
    assert input_height |> is_integer()
    assert input_width |> is_integer()
    assert graph |> is_reference()
    assert output_info |> is_bitstring()
    assert column_list |> is_list()
  end
end
