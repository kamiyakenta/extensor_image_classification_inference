defmodule ExtensorInference.ConsignmentInferenceTest do
  use ExUnit.Case, async: true
  alias ExtensorInference.ConsignmentInference, as: CI

  test "consignment_inference" do
    assert CI.consignment_inference() == :ok
  end
end
