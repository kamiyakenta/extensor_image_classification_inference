defmodule ExecuteInference do
  alias Extensor, as: Et
  alias Mogrify, as: Mf
  alias Imagineer, as: Im
  import LoadPreTrainedModel, only: [prepare_trained_model: 0]

  defp convert_image(image_path) do
    img_ext = Path.extname(image_path)
    if img_ext == ".png" do
      image_path
    else
      png_image = Mf.open(image_path) |> Mf.format("png") |> Mf.save
      png_image.path
    end
  end

  def inference(image_path) do
    # 毎回読み込むことになる
    [column_list, [input_info, output_info, input_height, input_width], graph] = prepare_trained_model()

    Mf.open(image_path) |> Mf.resize_to_fill("#{input_height}x#{input_width}") |> Mf.save(in_place: true)
    {:ok, image} = Im.load(convert_image(image_path))
    normalized_image_list = for image_pixels_width <- image.pixels, do: Enum.map(image_pixels_width, fn(pixel) -> Tuple.to_list(pixel) |> Enum.map(fn(x) -> x/255 end) end)
    image_pixels = [normalized_image_list]
    input_tensor = %{
      input_info => Et.Tensor.from_list(image_pixels)
    }

    output_run_session = Et.Session.run!(graph, input_tensor, [output_info])

    prob_tensor_results = Et.Tensor.to_list(output_run_session[output_info])

    prob_list = List.flatten(prob_tensor_results)
    max_prob = Enum.max(prob_list)
    List.zip([column_list, prob_list]) |> Enum.map(fn({column, prob}) -> if prob == max_prob, do: IO.puts "#{column}   #{prob}\n" end )
  end

  def execute_inference do
    image_path = "./images/image.jpg"
    inference(image_path)
  end
end
ExecuteInference.execute_inference()
