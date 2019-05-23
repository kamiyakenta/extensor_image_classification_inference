defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
  alias ExtensorInference.MyExperimentCode, as: MEC
  alias ImageClassification.InferenceService, as: IS

  setup_all do
    graph = "./pre_trained_model/model.pb"
    label = "./labels.txt"
    io_json = "./pre_trained_model/io.json"
    images = Path.wildcard("./images/**")
    service = %IS{graph: graph, label: label, io_info: io_json}
    %{service: service, images: images}
  end

  test "my_experiment_code", %{service: service, images: images} do
    assert IS.load_model(service) == :ok
    assert MEC.my_experiment_code() == :ok
  end
end

# require IEx; IEx.pry()
