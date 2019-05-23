defmodule ImageClassification.InferenceService do
  alias Extensor, as: Et
  alias Mogrify, as: Mf
  alias Imagineer, as: Im
  alias ImageClassification.InferenceService, as: IS
  use GenServer

  @name :inference_service

  defstruct [:graph, :label, :io_info]

  def init(init_arg) do
    {:ok, init_arg}
  end

  defp start(init \\ []) do
    GenServer.start_link(IS, init, name: @name)
    :ok
  end

  defp get() do
    GenServer.call(@name, :get)
  end

  defp update(new_state) do
    GenServer.cast(@name, {:update, new_state})
  end

  def update_image(new_state) do
    GenServer.cast(@name, {:update_image, new_state})
  end

  # GenServer Callback functions
  def handle_call(:get, _client, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

  def handle_cast({:update_image, new_state}, state) do
    f = fn (state) -> if state |> Enum.at(0) |> Map.get(:image), :do( state = tl state) end
    edit_state = f.(state)
    input_tensor = load_image(new_state, Enum.at(state, 0))
    next_state = state |> Enum.into([%{:image => input_tensor}])
    {:noreply, next_state}
  end

  defp convert_image(image_path) do
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

  def load_model(%IS{graph: model_path, label: label_path, io_info: io_json_path}) do
    # プロセスの立ち上げ
    start()

    # graphの読み込み
    graph = Et.Session.load_frozen_graph!(model_path)

    # labelの読み込み
    file = File.read!(label_path)
    column_list = String.split(file, "\n")
                  |> Enum.map(fn x -> Regex.replace(~r/\d+ /, x, "") end)

    # io_infoの読み込み
    io_infos = io_json_path
               |> File.read!()
               |> Poison.decode!()
    input_info = Enum.at(io_infos["input"], 0)
    output_info = Enum.at(io_infos["output"], 0)
    input_height = Enum.at(io_infos["inputShape"], 1)
    input_width = Enum.at(io_infos["inputShape"], 2)

    update([[input_info, input_height, input_width], [graph, output_info, column_list]])

  end

  def load_image(image_path, [input_info, input_height, input_width]) do
    Mf.open(image_path)
    |> Mf.resize_to_fill("#{input_height}x#{input_width}")
    |> Mf.save(in_place: true)
    {:ok, image} = Im.load(convert_image(image_path))
    normalized_image_list = for image_pixels_width <- image.pixels, do: Enum.map(image_pixels_width, fn(pixel) -> Tuple.to_list(pixel) |> Enum.map(fn(x) -> x/255 end) end)
    image_pixels = [normalized_image_list]
    %{ input_info => Et.Tensor.from_list(image_pixels) }
  end

  def inference(input_tensor) do
    # 準備
    [graph, output_info, column_list] = Enum.at(get(), 1)

    # 実行
    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])
    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])
    prob_list = List.flatten(prob_tensor_results)
    max_prob = Enum.max(prob_list)
    List.zip([column_list, prob_list])
    |> Enum.map(
      fn({column, prob}) ->
        if prob == max_prob, do: (
          IO.puts "#{column}   #{prob}"
        )
      end
    )
  end
end
