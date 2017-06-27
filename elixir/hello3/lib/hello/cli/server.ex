defmodule Hello.Cli.Server do
    
  def start(state) do
    case :gen_tcp.accept(state.lsock) do
      {:ok, sock} ->
        loop(sock, state)
        start(state)
      other ->
        IO.puts("TCP accept error: #{inspect other}")
    end
  end
  
  defp loop(sock, state) do
    :inet.setopts(sock, active: :once)
    receive do
      {:tcp, ^sock, data} ->
        case process(data, state) do
          {:reply, ans, state} ->
            :gen_tcp.send(sock, ans)
            loop(sock, state)
          :halt ->
            IO.puts("Bye...")
            :ok
        end
      {:tcp_close, ^sock} ->
        IO.puts("TCP socket #{inspect sock} closed [#{self()}]")
        :ok
    end
  end

  defp process("USER " <> user, state) do
    Hello.Store.put(state.store, :user, String.trim(user))
    {:reply, "OK\n", state}
  end
    
  defp process("HELLO" <> _, state) do
    case Hello.Store.get(state.store, :user) do
      nil -> {:reply, "Who are you ?\n", state}
      user -> {:reply, "Hello #{user} !\n", state}
    end
  end

  defp process("GET " <> key, state) do
    key = :"#{String.downcase(String.trim(key))}"
    {:reply, "GET #{key}: " <> Hello.Store.get(state.store, key) <> "\n", state}
  end

  defp process("PUT " <> data, state) do
    data = String.trim(data)
    
    # Code will fail if more than 2 words (see how server is restarted)
    [key, value] = String.split(data)
    
    # Code won't fail
    #[key | value] = String.split(data)
    #[key, value] = String.split(data, trim: true, parts: 2)
    
    key = :"#{String.downcase(key)}"
    Hello.Store.put(state.store, key, value)
    # Hello.Store.put(key, Enum.join(value, " "))
    {:reply, "STORE: #{key} => #{value}\n", state}
  end

  defp process("KEYS" <> _, state) do
    {:reply, "NOT IMPLEMENTED...", state}
  end

  defp process("BYE" <> _, _state) do
    :halt
  end

  defp process(data, state) do
    {:reply, "ERROR: #{data}", state}
  end
end
