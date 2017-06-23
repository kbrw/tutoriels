defmodule HelloRest.Store do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  def put(ref, key, value) do
    GenServer.cast(ref, {:store, key, value})
  end

  def get(ref, key, default \\ nil) do
    GenServer.call(ref, {:get, key, default})
  end

  def delete(ref, key) do
    GenServer.call(ref, {:delete, key})
  end

  ###
  ### Callbacks
  ###
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:get, key, default}, _from, state) do
    ret = Map.get(state, key, default)
    {:reply, ret, state}
  end

  def handle_call({:delete, key}, _from, state) do
    ret = Map.delete(state, key)
    {:reply, ret, state}
  end

  def handle_cast({:store, key, value}, state) do
    state = Map.put(state, key, value)
    {:noreply, state}
  end
end
