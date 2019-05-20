defmodule ConsignmentInrference do
  alias InferenceService, as: IS

  def consignment_inference do
    model_path = "./pre_trained_model/model.pb"
    label_path = "./labels.txt"
    io_json_path = "./pre_trained_model/io.json"
    service = %IS{graph: model_path, label: label_path, io_info: io_json_path}
    pre_trained_model = IS.load_model(service)

    # -------------------------
    image_path = "./images/image.jpg"
    input_tensor = IS.load_image(pre_trained_model, image_path)
    IS.inference(pre_trained_model, input_tensor)
    # -------------------------
  end

end

ConsignmentInrference.consignment_inference()
# require IEx; IEx.pry
