defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
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
    test "example result", %{service: service, images: images} do
      assert IS.load_model(service) == :ok
      image_path = "./images/galloping_giraffe.png"

    end

    test "Source code itself result" do
      assert MEC.my_experiment_code() == :ok
    end
  end
end

# require IEx; IEx.pry()
