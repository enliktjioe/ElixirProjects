defmodule WikiDream.MixProject do
  use Mix.Project

  def project do
    [
      app: :wiki_dream,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env == :prod,
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
      {:httpoison, "~> 1.6.2"},
      {:poison, "~> 3.1"}
    ]
  end
end
