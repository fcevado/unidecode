defmodule Unidecode.Mixfile do
  use Mix.Project

  def project do
    [app: :unidecode,
     version: "0.0.1",
     elixir: "~> 1.4",
     description: description(),
     source_url: "https://github.com/fcevado/unidecode",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :con_cache],
     mod: {Unidecode.Application, []}]
  end

  defp description do
    """
    Transliterate from Unicode to ASCII.
    Based upon [Text::Unidecode](http://search.cpan.org/~sburke/Text-Unidecode-1.30/lib/Text/Unidecode.pm) perl module.
    """
  end

  defp package do
    [
      name: :unidecode,
      files: ["priv", "lib/unidecode.ex", "lib/unidecode", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Flávio Moreira Vieira"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/fcevado/unidecode"}
    ]
  end

  defp deps do
    [
      {:con_cache, "~> 0.12"},
      {:ex_doc, "~> 0.16", only: :dev},
      {:earmark, "~> 1.2", only: :dev}
    ]
  end
end
