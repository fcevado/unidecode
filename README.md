# Unidecode

An elixir implementation of [Text::Unidecode](http://search.cpan.org/~sburke/Text-Unidecode-1.30/) a perl module to transliterate Unicode characters to US-ASCII.

It doesn't change encoding, as every string in Elixir, all results still are UTF8/Unicode characters.
But are they are easy to convert to ASCII. Let's say you have the word `código` that is the portuguese word for code, and try to convert it to a charlist.

```elixir
iex> to_charlist("código")
[99, 243, 100, 105, 103, 111]
```

Unicode is made to make this kind of operation give you better results.

```elixir
iex> "código" |> Unidecode.decode |> to_charlist
'codigo'
```

This isn't the exact characters, but is readable and intelligible to anyone who speaks portuguese.

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

## Installation

Add unidecode to your depencies

```elixir
def deps do
  [{:unidecode, "~> 1.0.0"}]
end
```

## [Changelog](./CHANGELOG.md)

## [Code of Conduct](./CODE_OF_CONDUCT.md)

## [License](./LICENSE)

Unidecode is under Apache v2.0 license.
