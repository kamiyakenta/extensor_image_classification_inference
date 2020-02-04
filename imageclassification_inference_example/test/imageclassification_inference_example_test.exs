defmodule ImageclassificationInferenceExampleTest do
  use ExUnit.Case
  doctest ImageclassificationInferenceExample

  test "execute_inference" do
    assert ImageclassificationInferenceExample.execute_inference() == :ok
  end
end
