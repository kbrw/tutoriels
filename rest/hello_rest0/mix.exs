defmodule HelloRest.Mixfile do
  use Mix.Project

  def project do
    [app: :hello_rest,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      mod: {HelloRest.App, []},
      applications: [
	:cowboy,
	:logger
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ewebmachine, "~> 2.1"},
      {:cowboy, "~> 1.0"},
      {:poison, "~> 3.0"}
    ]
  end
end
