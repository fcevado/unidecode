defmodule Unidecode.Mixfile do
  use Mix.Project

  def project do
    [app: :unidecode,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :con_cache],
     mod: {Unidecode.Application, []}]
  end

  defp deps do
    [
      {:con_cache, "~> 0.12"}
    ]
  end
end
