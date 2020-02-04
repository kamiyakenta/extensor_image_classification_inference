defmodule Inference.ImageClassification.ImageLoaderTest do
  use ExUnit.Case, async: true
  alias Inference.ImageClassification.ImageLoader

  setup do
    image_path = Path.join(["test", "inference", "imageclassification", "images", "giraffe.png"])

    {:ok, image_path: image_path}
  end

  test "load image", state do
    input_tensor =
      state[:image_path]
      |> ImageLoader.load_image(["input_1", 256, 256])

    loaded_image = input_tensor["input_1"]
    assert loaded_image.data |> is_binary()
    assert loaded_image.shape == {1, 256, 256, 3}
    assert loaded_image.type == :float
  end
end
