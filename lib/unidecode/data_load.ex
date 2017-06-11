defmodule Unidecode.DataLoad do
  @moduledoc false

  alias Unidecode.{DataLoad, Cache}

  def task do
    :unidecode
    |> :code.priv_dir
    |> Path.join("/unicode_data/*.csv")
    |> Path.wildcard
    |> Stream.map(fn file -> Task.Supervisor.async(DataLoad.Supervisor, DataLoad, :load_file, [file]) end)
    |> Enum.each(&Task.await/1)

    Supervisor.stop(DataLoad.Supervisor, :normal)
  end

  def load_file(file) do
    file
    |> File.stream!([:read], :line)
    |> Stream.map(&(String.split(&1, ";")))
    |> Stream.map(&(Enum.take(&1, 2)))
    |> Enum.each(&cache_symbol/1)
  end

  defp cache_symbol([code, char]) do
    code
    |> prepare_code
    |> Cache.put(char)
  end

  defp prepare_code(code) do
    code = String.to_integer(code, 16)
    <<code::utf8>>
  end
end
