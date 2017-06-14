defmodule Hello.Cli do
  def start_link(listeners, port) do
    IO.puts("Start CLI on TCP #{port}")
    opts = [{:active, false}, {:packet, :line}, {:reuseaddr, true}, :binary]
    case :gen_tcp.listen(port, opts) do
      {:ok, lsock} ->
	Enum.each(1..listeners, fn _ ->
	  spawn(Hello.Cli.Server, :start, [lsock])
	end)
	{:ok, port} = :inet.port(lsock)
	Agent.start_link(fn -> port end)
    end
  end
end
