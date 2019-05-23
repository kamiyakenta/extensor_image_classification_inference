defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias ExtensorInference.MyExperimentCode, as: MEC
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
      fun = fn ->
        image_path
        |> IS.load_image()
        |> IS.inference()
      end
      result = String.split(capture_io(fun), "   ")
      # result = ["084.giraffe", "0.9985604882240295"]
      require IEx; IEx.pry
      assert Enum.at(result, 0) == "084.giraffe"
      assert Enum.at(result, 1)
      |> String.replace("\n", "")
      |> String.to_float() > 0.95
    end

    test "Source code itself result" do
      assert MEC.my_experiment_code() == :ok
    end
  end
end

# require IEx; IEx.pry
