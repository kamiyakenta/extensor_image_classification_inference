defmodule ImageClassification.InferenceService do
  @moduledoc """
  This module holds and executes necessary data for inference in the process.
  """

  alias Extensor, as: Et
  alias Mogrify, as: Mf
  alias Imagineer, as: Im
  alias ImageClassification.InferenceService, as: IS
  require Logger

  defstruct [:graph, :label, :io_info]

  @name :inference_service

  @typedoc """
  This type is {type: data_type, shape: tuple, data: binary}.
  """
  @type et_tensor :: Extensor.Tensor.t

  @typedoc """
  This type is {:ok, pid} | :ignore | {:error, {:already_started, pid} | term}
  """
  @type on_start :: GenServer.on_start

  @typedoc """
  This type is file_path
  """
  @type path_type :: String.t
                | maybe_improper_list(
                  String.t | maybe_improper_list(any, String.t | []) | char,
                  String.t | []
                 )

  @typedoc """
  This type is frequent GenServer state
  """
  @type state_type :: [String.t | integer] | [reference | String.t | [String.t]]

  @typedoc """
  This is the type of this module's struct.
  """
  @type inference_service :: %IS{graph: String.t,
                                 label: path_type,
                                 io_info: path_type,
                                }

  @behaviour GenServer


  @doc """
  GenServer.init/1 callback.
  """
  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
  end

  @doc """
  Start our queue and link it.
  This is a function that wraps the helper function.
  """
  @spec start() :: on_start
  def start(), do: GenServer.start_link(IS, [], name: @name)

  @doc """
  Return state without doing any processing.
  This is a function that wraps the GenServer Call function.
  """
  @spec get() :: [state_type | [{String.t, integer}]]
  def get(), do: GenServer.call(@name, :get)

  @doc """
  Process inference and return state.
  This is a function that wraps the GenServer Call function.
  """
  @spec get_inference() :: [state_type]
  def get_inference(), do: GenServer.call(@name, :get_inference)

  @doc """
  Cast data processed by load_model function to state.
  This is a function that wraps the GenServer Cast function.
  """
  @spec update_model([state_type]) :: :ok
  def update_model(new_state), do: GenServer.cast(@name, {:update_model, new_state})

  @doc """
  Pass image_path to GenServer Callback function.
  This is a function that wraps the GenServer Cast function.
  """
  @spec update_image(String.t) :: :ok
  def update_image(new_state), do: GenServer.cast(@name, {:update_image, new_state})

  @doc """
  Pass the result of inference to state.
  This is a function that wraps the GenServer Cast function.
  """
  @spec update_result([{String.t | integer}]) :: :ok
  def update_result(new_state), do: GenServer.cast(@name, {:update_result, new_state})

  @doc """
  This is GenServer Callback functions.
  """
  @impl GenServer
  def handle_call(:get, _client, state) do
    {:reply, state, state}
  end

  @doc """
  Execute inference and remove the used image from state.
  This is GenServer Callback functions.
  """
  @impl GenServer
  def handle_call(:get_inference, _client, state) do
    inference(Enum.at(state, 0) |> Map.get(:image), Enum.at(state, 2))
    delete_image = fn (state) -> if state |> Enum.at(0) |> is_map(), do: tl state end
    edit_state = delete_image.(state)
    {:reply, edit_state, edit_state}
  end

  @doc """
  This is GenServer Callback functions.
  """
  @impl GenServer
  def handle_cast({:update_model, new_state}, _state) do
    {:noreply, new_state}
  end

  @doc """
  Call load_image function and pass the resulting input_tensor to state.
  This is GenServer Callback functions.
  """
  @impl GenServer
  def handle_cast({:update_image, new_state}, state) do
    input_tensor = load_image(new_state, Enum.at(state, 0))
    next_state = [%{:image => input_tensor}] ++ state
    {:noreply, next_state}
  end

  @doc """
  Add result of inference to state
  This is GenServer Callback functions.
  """
  @impl GenServer
  def handle_cast({:update_result, new_state}, state) do
    next_state = state ++ [new_state]
    {:noreply, next_state}
  end

  @doc """
  Convert to .png file.
  """
  @spec convert_image(path_type) :: path_type
  def convert_image(image_path) do
    img_ext = Path.extname(image_path)
    if img_ext == ".png" do
      image_path
    else
      png_image = Mf.open(image_path)
                  |> Mf.format("png")
                  |> Mf.save
      png_image.path
    end
  end

  @doc """
  Receive the structure of this process and find the necessary data.
  It also executes start function and update_model function.
  """
  @spec load_model(inference_service) :: :ok
  def load_model(%IS{graph: model_path, label: label_path, io_info: io_json_path}) do
    {:ok, _pid} = start()

    graph = Et.Session.load_frozen_graph!(model_path)

    file = File.read!(label_path)
    column_list = String.split(file, "\n")
                  |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)

    io_infos = io_json_path
               |> File.read!()
               |> Poison.decode!()
    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)

    update_model([[input_info, input_height, input_width], [graph, output_info, column_list]])
  end

  @doc """
  Create input_tensor using extensor
  """
  @spec load_image(String.t, [String.t | integer]) :: %{String.t => et_tensor}
  def load_image(image_path, [input_info, input_height, input_width]) do
    Logger.disable(self())
    _image = Mf.open(image_path)
             |> Mf.resize_to_fill("#{input_height}x#{input_width}")
             |> Mf.save(in_place: true)
    {:ok, image} = Im.load(convert_image(image_path))
    normalized_image = Enum.map(image.pixels, fn(image_pixels_width) ->
                        Enum.map(image_pixels_width, fn(pixel) ->
                          Tuple.to_list(pixel) |> Enum.map(fn(x) ->
                            x/255
                          end)
                        end)
                      end)
    image_pixels = [normalized_image]
    Logger.enable(self())
    %{ input_info => Et.Tensor.from_list(image_pixels) }
  end

  @doc """
  After executing inference using the extensor, pass the result to the update_result function.
  """
  @spec inference(%{String.t => et_tensor}, [reference | String.t | [String.t]]) :: :ok
  def inference(input_tensor, [graph, output_info, column_list]) do
    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])
    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])
    prob_list = List.flatten(prob_tensor_results)
    max_prob = Enum.max(prob_list)
    _result = List.zip([column_list, prob_list])
              |> Enum.map(
                  fn({column, prob}) ->
                    if prob == max_prob, do: (
                      IO.puts "#{column}   #{prob}"
                      update_result([{column, prob}])
                    )
                  end
                )
    :ok
  end
end
