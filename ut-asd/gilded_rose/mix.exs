defmodule GildedRose.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gilded_rose,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:gilded_rose, "~> 0.1.0"},
      {:coverex, "~> 1.4.10", only: :test}
    ]
  end
end