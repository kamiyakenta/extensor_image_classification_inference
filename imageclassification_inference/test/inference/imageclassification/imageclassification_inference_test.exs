defmodule Inference.ImageClassification.ImageclassificationInferenceTest do
  use ExUnit.Case, async: true

  setup do
    Logger.configure(level: :warn)
    model_dir = Path.join(["test", "inference", "imageclassification", "model"])
    image_path = Path.join(["test", "inference", "imageclassification", "images", "giraffe.png"])

    {:ok, model_dir: model_dir, image_path: image_path}
  end

  test "load model and image, execute inference", state do
    assert :ok ==
             ImageclassificationInference.load_model(
               Path.join([state[:model_dir], "model.pb"]),
               Path.join([state[:model_dir], "labels.txt"]),
               Path.join([state[:model_dir], "io.json"])
             )

    assert :ok ==
             state[:image_path]
             |> ImageclassificationInference.load_image()

    result = ImageclassificationInference.inference()
    assert result[:name] == "084.giraffe"
    assert result[:score] > 0.97
  end
end
