defmodule Unidecode.Decoder do
  @moduledoc """
  This module takes care of transliterate a single grapheme.
  It's only documented so you can use a better strategy to transliterate larger texts.
  """
  data =
    :unidecode
    |> :code.priv_dir()
    |> Path.join("/unidecode.term")
    |> File.read!()
    |> :erlang.binary_to_term()

  for {u, c} <- data do
    def decode(unquote(u)), do: unquote(c)
  end

  @doc """
  Returns the transliteration of a single grapheme.
  ## Examples
      iex> Unidecode.Decoder.decode("⠋")
      "f"
      iex> Unidecode.Decoder.decode("ニ")
      "ni"
      iex> Unidecode.Decoder.decode("Р")
      "R"
      iex> Unidecode.Decoder.decode("ç")
      "c"
  """
  @spec decode(String.t()) :: String.t()
  def decode(c), do: c
end
