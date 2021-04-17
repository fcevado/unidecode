defmodule Unidecode.Decoder do
  @moduledoc """

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
  """
  @spec decode(String.t()) :: String.t()
  def decode(c), do: c
end
