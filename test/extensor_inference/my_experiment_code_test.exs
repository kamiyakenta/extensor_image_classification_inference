defmodule ExtensorInference.MyExperimentCodeTest do
  use ExUnit.Case, async: true
  alias ExtensorInference.MyExperimentCode, as: MEC

  test "my_experiment_code" do
    assert MEC.my_experiment_code() == :ok
  end
end
