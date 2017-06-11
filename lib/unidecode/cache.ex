defmodule Unidecode.Cache do
  @moduledoc false

  def put(key, value), do: ConCache.put(:unidecode, key, value)
  def get(key), do: ConCache.get(:unidecode, key)
end
