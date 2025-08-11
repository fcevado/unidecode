defmodule Unidecode.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unidecode,
      version: "1.0.2",
      elixir: "~> 1.6",
      description: description(),
      source_url: "https://github.com/fcevado/unidecode",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp description do
    ~S(
    Transliterate from Unicode to ASCII.

    Based on Text::Unidecode.
    )
  end

  defp package do
    [
      name: :unidecode,
      files: ["priv", "lib/unidecode.ex", "lib/unidecode", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Flávio Moreira Vieira"],
      licenses: ["Apache-2.0"],
      links: %{
        "Github" => "https://github.com/fcevado/unidecode",
        "Text::Unidecode(Original Perl Module)" =>
          "http://search.cpan.org/~sburke/Text-Unidecode-1.30/"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.38", only: :dev}
    ]
  end
end
