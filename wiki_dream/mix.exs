defmodule WikiDream.MixProject do
  use Mix.Project

  def project do
    [
      app: :wiki_dream,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: WikiDream.CLI], #Added escript
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
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 2.0"}
    ]
  end
end
