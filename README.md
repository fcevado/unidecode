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

## Installation

Add unidecode to your depencies and to extra applications

```elixir
def deps do
  [{:unidecode, "~> 0.1.0"}]
end

def application do
  [extra_applications: [:logger, :unidecode],
   mod: {YourApp.Application, []}]
end
```

## Contributing

As we all are used to:
 - fork
 - create a branch for your contribution
 - add your commits(I try to stick with this pattern [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/))
 - create a PR for your changes
 
#### Where are room for contributions?

We always want better documentation and, although this library has a small and concise documentation, anywhere you see that it can be improved it will be warmly welcomed.

You can also help to add csv translitaration tables. Those tables are in `priv/unicode_data/`.
Inside this folder will be a file with all unicode characters description called `UnicodeData.txt` and all the csv tables.
Those tables have a simple structure: `{unicode code};{ascii char};{code description}`.
I'm keeping the description so those csv files can be useful outside of this implementation context.
To ease the work of dealing with `UnicodeData.txt` and csv files, I created a simple `mix task` to filter data from `UnicodeData.txt` and create a csv file.

```shell
$ mix generate_csv filename=caucasian_albanian include=caucasian,albanian exclude=control,indicator,input
```

After running this task you will have a file `priv/unicode_data/caucasian_albanian.csv`.
All parameters are required, I strongly recommend to always use the exclude parameters as in this example.

## [Changelog](./CHANGELOG.md)

## [Code of Conduct](./CODE_OF_CONDUCT.md)

## [License](./LICENSE)
Unidecode is under Apache v2.0 license.
