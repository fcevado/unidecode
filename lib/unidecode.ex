defmodule Unidecode do
  @moduledoc """
  #TODO doc
  """

  @doc """
  #TODO doc
  """
  @spec unidecode(String.t) :: String.t
  def unidecode(string), do: transliterate(string)

  @doc """
  #TODO doc
  """
  @spec unidecode(String.t) :: String.t
  def decode(string), do: transliterate(string)

  @spec unidecode(String.t) :: String.t
  defp transliterate(string) do
    string
    |> String.graphemes
    |> Stream.map(&transliterate_char/1)
    |> Enum.join
  end

  @spec unidecode(String.t) :: String.t
  defp transliterate_char(char) do
    case Unidecode.Cache.get(char) do
      nil -> char
      new_char -> new_char
    end
  end
end
