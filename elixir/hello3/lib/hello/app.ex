defmodule Hello.App do
  use Application

  def start(_type, _args) do
    Hello.Sup.start_link()
  end
end
