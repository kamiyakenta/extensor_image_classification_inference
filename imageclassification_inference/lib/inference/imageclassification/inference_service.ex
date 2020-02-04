defmodule Inference.ImageClassification.InferenceService do
  @moduledoc """
  This module holds the data required for inference in the process.
  """
  alias Inference.ImageClassification.ImageLoader
  alias Inference.ImageClassification.ModelLoader
  alias Inference.ImageClassification.ExecuteInference

  @name :inference_service

  @typedoc """
  This type is {:ok, pid} | :ignore | {:error, {:already_started, pid} | term}
  """
  @type on_start :: GenServer.on_start()

  @behaviour GenServer

  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
  end

  @spec start() :: on_start
  def start(), do: GenServer.start_link(__MODULE__, [], name: @name)

  @doc """
  Wrapping the GenServer Call function.
  """
  @spec execute_inference() :: %{name: String.t(), score: integer()}
  def execute_inference(), do: GenServer.call(@name, :execute_inference)

  @doc """
  Casting data processed by load_model() function of ModelLoader to state.
  Wrapping the GenServer Cast function.
  """
  @spec load_model([String.t()]) :: :ok
  def load_model(model_paths), do: GenServer.cast(@name, {:load_model, model_paths})

  @doc """
  Casting data processed by load_image() function of ImageLoader to state.
  Wrapping the GenServer Cast function.
  """
  @spec load_image(String.t()) :: :ok
  def load_image(image_path), do: GenServer.cast(@name, {:load_image, image_path})

  @doc """
  Execute inference with GenServer state data.
  Returning the inference result and discarding the loaded image information.
  """
  @impl GenServer
  def handle_call(:execute_inference, _client, state) do
    result =
      Enum.at(state, 0)
      |> Map.get(:image)
      |> ExecuteInference.inference(Enum.at(state, 2))

    {:reply, result, tl(state)}
  end

  @doc """
  The result of ModelLoader.load_model () is always kept in the state.
  """
  @impl GenServer
  def handle_cast({:load_model, paths}, _state) do
    state = ModelLoader.load_model(paths)
    {:noreply, state}
  end

  @doc """
  Passing ImageLoader.load_image() result input_tensor to state.
  """
  @impl GenServer
  def handle_cast({:load_image, path}, state) do
    input_tensor = ImageLoader.load_image(path, Enum.at(state, 0))
    new_state = [%{image: input_tensor}] ++ state
    {:noreply, new_state}
  end
end
