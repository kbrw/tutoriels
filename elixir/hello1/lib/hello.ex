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
    Map.get(store, key)
  end
end
