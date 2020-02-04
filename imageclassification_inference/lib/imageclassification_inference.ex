defmodule ImageclassificationInference do
  @moduledoc """
  Model loading, image loading, and inference execution necessary for image Classification inference are prepared.
  """
  alias Inference.ImageClassification.InferenceService

  @doc """
  The process of InferenceService is started with this function.
  Calling the load_model function of InferenceService that wraps the Genserver cast function.
  """
  @spec load_model(String.t(), String.t(), String.t()) :: :ok
  def load_model(graph_path, label_path, io_json_path) do
    {:ok, _pid} = InferenceService.start()

    :ok =
      [graph_path, label_path, io_json_path]
      |> InferenceService.load_model()
  end

  @doc """
  Calling the load_image function of InferenceService that wraps the Genserver cast function.
  """
  @spec load_image(String.t()) :: :ok
  def load_image(input_path) do
    :ok =
      input_path
      |> InferenceService.load_image()
  end

  @doc """
  Calling the execute_inference function of InferenceService that wraps the Genserver cast function.
  """
  @spec inference() :: %{:name => binary(), :score => integer()}
  def inference() do
    InferenceService.execute_inference()
  end
end
