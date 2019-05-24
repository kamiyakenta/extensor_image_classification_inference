defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
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
      IS.get_inference()
      [{column, prob}] = List.last(IS.get())
      assert column == "084.giraffe"
      assert prob > 0.95
  end
  end
end
