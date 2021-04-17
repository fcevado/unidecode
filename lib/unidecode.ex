defmodule Unidecode do
  @moduledoc """
  #TODO doc
  """

  @doc """
  #TODO doc
  """
  @spec unidecode(String.t()) :: String.t()
  def unidecode(string), do: transliterate(string)

  @doc """
  #TODO doc
  """
  @spec decode(String.t()) :: String.t()
  def decode(string), do: transliterate(string)

  @spec transliterate(String.t()) :: String.t()
  defp transliterate(string) do
    string
    |> String.graphemes()
    |> Enum.map(&Unidecode.Decoder.decode/1)
    |> Enum.join()
  end
end
