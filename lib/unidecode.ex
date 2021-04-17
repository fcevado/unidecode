defmodule Unidecode do
  @moduledoc """
  This library provides functions to transliterate Unicode characters to an ASCII approximation.

  ## Design Philosophy(taken from original Unidecode perl library)
  Unidecode's ability to transliterate from a given language is limited by two factors:

  - The amount and quality of data in the written form of the original language
    So if you have Hebrew data that has no vowel points in it, then Unidecode cannot guess what vowels should appear in a pronunciation.
    S f y hv n vwls n th npt, y wn't gt ny vwls n th tpt.
    (This is a specific application of the general principle of "Garbage In, Garbage Out".)

  - Basic limitations in the Unidecode design
    Writing a real and clever transliteration algorithm for any single language usually requires a lot of time, and at least a passable knowledge of the language involved.
    But Unicode text can convey more languages than I could possibly learn (much less create a transliterator for) in the entire rest of my lifetime.
    So I put a cap on how intelligent Unidecode could be, by insisting that it support only context-insensitive transliteration.
    That means missing the finer details of any given writing system, while still hopefully being useful.

  Unidecode, in other words, is quick and dirty.
  Sometimes the output is not so dirty at all: Russian and Greek seem to work passably; and while Thaana (Divehi, AKA Maldivian) is a definitely non-Western writing system, setting up a mapping from it to Roman letters seems to work pretty well.
  But sometimes the output is very dirty: Unidecode does quite badly on Japanese and Thai.

  If you want a smarter transliteration for a particular language than Unidecode provides, then you should look for (or write) a transliteration algorithm specific to that language, and apply it instead of (or at least before) applying Unidecode.

  In other words, Unidecode's approach is broad (knowing about dozens of writing systems), but shallow (not being meticulous about any of them).
  """

  @doc """
  Returns string with its UTF-8 characters transliterated to ASCII ones.
  ## Examples
      iex> Unidecode.unidecode("⠋⠗⠁⠝⠉⠑")
      "france"
      iex> Unidecode.unidecode("فارسی")
      "frsy"
      iex> Unidecode.unidecode("ニホンコク")
      "nihonkoku"
      iex> Unidecode.unidecode("Россия")
      "Rossiia"
      iex> Unidecode.unidecode("paçoca")
      "pacoca"
  """
  @spec unidecode(String.t()) :: String.t()
  def unidecode(string), do: transliterate(string)

  @doc """
  Returns string with its UTF-8 characters transliterated to ASCII ones.
  ## Examples
      iex> Unidecode.decode("⠋⠗⠁⠝⠉⠑")
      "france"
      iex> Unidecode.decode("فارسی")
      "frsy"
      iex> Unidecode.decode("ニホンコク")
      "nihonkoku"
      iex> Unidecode.decode("Россия")
      "Rossiia"
      iex> Unidecode.decode("paçoca")
      "pacoca"
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
