defmodule ExtensorInference.MyExperimentCode do
  alias ImageClassification.InferenceService, as: IS

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
      |> IS.inference()
    end)
  end

end

ExtensorInference.MyExperimentCode.my_experiment_code()
