defmodule Hello.Cli.Server do
  def start(lsock) do
    case :gen_tcp.accept(lsock) do
      {:ok, sock} ->
	loop(sock)
	start(sock)
      other ->
	IO.puts("TCP accept error: #{inspect other}")
    end
  end

  
  defp loop(sock) do
    :inet.setopts(sock, active: :once)
    receive do
      {:tcp, ^sock, data} ->
        ans = process(data)
        :gen_tcp.send(sock, ans)
	loop(sock)
      {:tcp_close, ^sock} ->
        IO.puts("TCP socket #{inspect sock} closed [#{self()}]")
        :ok
    end
  end

  defp process("USER " <> user) do
    Hello.Store.put(:user, String.trim(user))
    "OK\n"
  end
    
  defp process("HELLO" <> _) do
    case Hello.Store.get(:user) do
      nil -> "Who are you ?\n"
      user -> "Hello #{user} !\n"
    end
  end

  defp process("GET " <> key) do
    key = :"#{String.downcase(String.trim(key))}"
    "GET #{key}: " <> Hello.Store.get(key) <> "\n"
  end

  defp process("PUT " <> data) do
    data = String.trim(data)
    
    # Code will fail if more than 2 words (see how server is restarted)
    [key, value] = String.split(data)
    
    # Code won't fail
    #[key | value] = String.split(data)
    #[key, value] = String.split(data, trim: true, parts: 2)
    
    key = :"#{String.downcase(key)}"
    Hello.Store.put(key, value)
    # Hello.Store.put(key, Enum.join(value, " "))
    "STORE: #{key} => #{value}\n"
  end

  defp process("BYE" <> _) do
    exit(:user)
  end

  defp process(data) do
    "ERROR: #{data}"
  end
end
