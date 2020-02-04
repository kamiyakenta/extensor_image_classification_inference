defmodule Inference.ImageClassification.ExecuteInference do
  @moduledoc """
  Preparing a function to inference using information of image tensor and model.
  """

  @typedoc """
  This type is {type: data_type, shape: tuple, data: binary}.
  """
  @type et_tensor :: Extensor.Tensor.t()

  @doc """
  After executing inference using the extensor, return the best result.
  """
  @spec inference(%{String.t() => et_tensor}, [reference | String.t() | [String.t()]]) :: :ok
  def inference(input_tensor, [graph, output_info, column_list]) do
    output_run_session = Extensor.Session.run!(graph, input_tensor, [output_info])
    prob_tensor_results = Extensor.Tensor.to_list(output_run_session[output_info])
    prob_list = List.flatten(prob_tensor_results)

    max_prob =
      prob_tensor_results
      |> List.flatten()
      |> Enum.max()

    _results =
      List.zip([column_list, prob_list])
      |> Enum.map(fn {column, prob} ->
        if prob == max_prob, do: %{name: column, score: prob}
      end)
      |> Enum.max()
  end
end
