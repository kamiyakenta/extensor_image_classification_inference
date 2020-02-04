defmodule ImageclassificationInference.MixProject do
  use Mix.Project

  def project do
    [
      app: :imageclassification_inference,
      version: "0.1.0",
      elixir: "~> 1.8",
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

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:extensor, "~> 0.1"},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:poison, "~> 4.0"},
      {:mogrify, "~> 0.7.2"},
      {:imagineer, "~> 0.3.3"}
    ]
  end
end
