defmodule Allbud.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://github.com/mithereal/ex_allbud.git"

  def project do
    [
      app: :allbud,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Allbud Strain Scraper",
      source_url: "https://github.com/mithereal/ex_allbud",
      description: "Scrape all strain information from allbud.com",
      docs: docs(),
      package: package(),
      aliases: aliases()
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: [:test, :dev]}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      files: ["lib", "priv", "mix.exs", "README.md"],
      maintainers: ["Jason Clark"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mithereal/ex_allbud"}

    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp aliases do
    [
      c: "compile",
      test: [
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "run priv/seeds.exs",
        "test"
      ],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
