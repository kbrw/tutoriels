defmodule Hello.Store do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :store)
  end

  def put(key, value) do
    GenServer.cast(:store, {:store, key, value})
  end

  def get(key, default \\ nil) do
    GenServer.call(:store, {:get, key}) || default
  end

  ###
  ### Callbacks
  ###
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:get, key}, _from, state) do
    ret = Map.get(state, key)
    {:reply, ret, state}
  end

  def handle_cast({:store, key, value}, state) do
    state = Map.put(state, key, value)
    {:noreply, state}
  end
end
