defmodule ExtensorInference.MyExperimentCode do
  @moduledoc """
  This module is an experimental module that passes data to the InferenceService module.
  """
  alias ImageClassification.InferenceService, as: IS

  @doc """
  Experimental main function.

  ## Example
      iex(1)> Inference.ImageClassification.MyExperimentCode.my_experiment_code()
      084.giraffe   0.9994377493858337
      084.giraffe   0.9985604882240295
      003.backpack   0.9995092153549194
      :ok
  """

  @spec my_experiment_code() :: :ok
  def my_experiment_code do
    model_path = "./pre_trained_model/model.pb"
    label_path = "./labels.txt"
    io_json_path = "./pre_trained_model/io.json"
    service = %IS{graph: model_path, label: label_path, io_info: io_json_path}
    IS.load_model(service)

    image_paths = Path.wildcard("./images/**")
    Enum.each(image_paths, fn(image_path) ->
      image_path
      |> IS.update_image()
      IS.get_inference()
    end)
  end

end

ExtensorInference.MyExperimentCode.my_experiment_code()
