defmodule Hayase.MixProject do
  use Mix.Project

  def project do
    [
      app: :hayase,
      version: "0.1.4",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: "Simple monads for Elixir",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Alexey Terekhov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tap349/hayase"},
      # > <https://hex.pm/docs/publish>
      # >
      # > When running the command to publish a package, Hex will
      # > create a tar file of all the files and directories listed
      # > in the :files property
      #
      # => don't add priv, test, .gitignore and docker-compose.yml
      # because they are required for running tests only - in that
      # case a way to go is to clone repository from GitHub
      files: ~w(
        lib
        .formatter.exs
        CHANGELOG.md
        LICENSE.md
        README.md
        mix.exs
      )
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false}
    ]
  end
end
