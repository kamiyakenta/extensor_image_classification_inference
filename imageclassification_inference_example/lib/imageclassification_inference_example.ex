defmodule ImageclassificationInferenceExample do
  @moduledoc """
  This module is an experimental module that passes data to the InferenceService module.
  """

  @doc """
  Prepare the model with prepare_models.sh.
  This function is the main function that executes the library imageclassification_inference.
  Displaying result of the number of images under the "images" directory on the standard output.

  ## Example
      iex(1)> ImageclassificationInferenceExample.execute_inference()
      :ok
  """
  @spec execute_inference() :: :ok
  def execute_inference() do
    Logger.configure(level: :warn)

    ImageclassificationInference.load_model(
      Path.join(["model", "model.pb"]),
      Path.join(["model", "labels.txt"]),
      Path.join(["model", "io.json"])
    )

    Path.wildcard(Path.join(["images", "**"]))
    |> Enum.each(fn image_path ->
      image_path
      |> ImageclassificationInference.load_image()

      IO.inspect(ImageclassificationInference.inference())
    end)
  end

  def main(_args \\ []) do
    execute_inference()
  end
end
