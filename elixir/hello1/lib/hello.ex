defmodule Hello do
  @moduledoc """
  Documentation for Hello.
  """

  def start do
    Map.new
  end
  
  def put(store, key, value) do
    Map.put(store, key, value)
  end

  def get(store, key) do
    if Map.has_key?(store, key) do
      {:ok, Map.get(store, key)}
    else
      {:error, :notfound}
    end
  end
end
