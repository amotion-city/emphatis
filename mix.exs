defmodule Emphatis.MixProject do
  use Mix.Project

  @app :emphatis

  def project do
    [
      app: @app,
      version: "0.2.1",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Emphatis, path: "bin/#{@app}"],
      description: description(),
      package: package(),
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
      {:string_naming, "~> 0.5"},
      {:credo, "~> 0.8", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}

      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description do
    """
    **Tiny library to convert text into unicode bold/italic/script.**

    Based on `StringNaming`.
    """
  end

  defp package do
    [
      name: @app,
      files: ~w|bin lib mix.exs README.md|,
      maintainers: ["Aleksei Matiushkin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/amotion-city/#{@app}",
        "Docs" => "https://hexdocs.pm/#{@app}"
      }
    ]
  end
end
