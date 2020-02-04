defmodule ImageclassificationInferenceExample.MixProject do
  use Mix.Project
  @app :imageclassification_inference_example
  @version "0.1.0"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.9",
      escript: [main_module: ImageclassificationInferenceExample],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        flags: [
          :error_handling,
          :no_behaviours,
          :no_contracts,
          :no_fail_call,
          :no_fun_app,
          :no_improper_lists,
          :no_match,
          :no_missing_calls,
          :no_opaque,
          :no_return,
          :no_undefined_callbacks,
          :no_unused,
          :race_conditions,
          :underspecs,
          :unknown,
          :unmatched_returns
          #  :overspecs,
          #  :specdiffs
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:imageclassification_inference, path: "../imageclassification_inference"}
    ]
  end
end
