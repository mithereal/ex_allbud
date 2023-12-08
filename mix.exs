defmodule Allbud.MixProject do
  use Mix.Project

  def project do
    [
      app: :allbud,
      version: "0.1.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Allbud Strain Scraper",
      source_url: "https://github.com/mithereal/ex_allbud",
      description: "Scrape all strain information from allbud.com",
      docs: docs(),
      package: package()
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
      {:floki, ">= 0.30.0"},
      {:tesla, ">= 0.0.0"},
      {:hackney, "~> 1.20"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mithereal/ex_allbud"}
    ]
  end

  defp docs do
    []
  end
end
