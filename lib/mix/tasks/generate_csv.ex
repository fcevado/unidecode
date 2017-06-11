defmodule Mix.Tasks.GenerateCsv do
  def run(args) do
    args = prepare_args(args)

    :unidecode
    |> :code.priv_dir
    |> Path.join("/unicode_data/#{args[:filename]}.csv")
    |> File.write(generate_csv(args))
  end

  defp prepare_args(args) do
    args
    |> Enum.filter(&String.contains?(&1, "="))
    |> Enum.map(&String.split(&1, "="))
    |> Enum.map(fn [k, v] -> {String.to_atom(k), String.split(v, ",")} end)
  end

  defp generate_csv(args) do
    :unidecode
    |> :code.priv_dir
    |> Path.join("/unicode_data/UnicodeData.txt")
    |> File.stream!([:read], :line)
    |> Stream.map(&String.downcase(&1))
    |> Stream.filter(&filter_args(&1, args))
    |> Stream.map(&prepare_line/1)
    |> Enum.join("\n")
  end

  defp filter_args(line, args) do
    Enum.any?(args[:include], &String.contains?(line, &1)) and
    not Enum.any?(args[:exclude], &String.contains?(line, &1))
  end

  defp prepare_line(line) do
    [code, descriptor] =
      line
      |> String.split(";")
      |> Enum.take(2)

    letter = define_letter(descriptor)

    Enum.join([code, letter, descriptor], ";")
  end

  defp define_letter(descriptor) do
    [descriptor | _] = String.split(descriptor, " with ")

    letter =
      descriptor
      |> String.split
      |> List.last

    if String.contains?(descriptor, "capital") do
      String.upcase(letter)
    else
      letter
    end
  end
end
