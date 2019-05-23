defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias ImageClassification.InferenceService, as: IS

  setup_all do
    graph = "./pre_trained_model/model.pb"
    label = "./labels.txt"
    io_json = "./pre_trained_model/io.json"
    service = %IS{graph: graph, label: label, io_info: io_json}
    %{service: service}
  end

  describe "my_experiment_code" do
    test "example result", %{service: service} do
      assert IS.load_model(service) == :ok
      image_path = "./images/galloping_giraffe.png"
      image_path
      |> IS.update_image()
      output_inference = fn -> IS.inference() end
      result = String.split(capture_io(output_inference), "   ")
      assert Enum.at(result, 0) == "084.giraffe"
      assert Enum.at(result, 1)
      |> String.replace("\n", "")
      |> String.to_float() > 0.95
    end
  end
end

# require IEx; IEx.pry
# iex -S mix test --trace
