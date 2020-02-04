defmodule Inference.ImageClassification.ImageLoader do
  @moduledoc """
  Prepare a function to change the extension to png and
  a function to load the image and resize the image according to the io_json information.
  """

  @typedoc """
  This type is {type: data_type, shape: tuple, data: binary}.
  """
  @type et_tensor :: Extensor.Tensor.t()

  @typedoc """
  This type is file path type.
  """
  @type path_type ::
          String.t()
          | maybe_improper_list(
              String.t() | maybe_improper_list(any, String.t() | []) | char,
              String.t() | []
            )

  @spec convert_image(path_type) :: path_type
  defp convert_image(image_path) do
    if Path.extname(image_path) == ".png" do
      image_path
    else
      png_image =
        image_path
        |> Mogrify.open()
        |> Mogrify.format("png")
        |> Mogrify.save()

      png_image.path
    end
  end

  @doc """
  Normalizing loaded and resized a image according to io_json.
  This result is kept in Genserver state until the end of Infence
  """
  @spec load_image(String.t(), [String.t() | integer]) :: %{String.t() => et_tensor}
  def load_image(image_path, [input_info, input_height, input_width]) do
    _ = image_path
    |> Mogrify.open()
    |> Mogrify.resize_to_fill("#{input_height}x#{input_width}")
    |> Mogrify.save(in_place: true)

    {:ok, image} =
      image_path
      |> convert_image()
      |> Imagineer.load()

    normalized_image = [
      image.pixels
      |> Enum.map(fn image_pixels_width ->
        Enum.map(image_pixels_width, fn pixel ->
          Tuple.to_list(pixel)
          |> Enum.map(fn x -> x / 255 end)
        end)
      end)
    ]

    %{input_info => Extensor.Tensor.from_list(normalized_image)}
  end
end
