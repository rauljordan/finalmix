defmodule FinalMix.MixProject do
  use Mix.Project

  def project do
    [
      app: :finalmix,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FinalMix, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, github: "elixir-grpc/grpc"},
      {:cubdb, "~> 0.17.0"},
      {:cowlib, "~> 2.9.0", override: true},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end

  defp elixirc_paths(_), do: ["lib"]
end
