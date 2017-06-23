defmodule HelloRest.App do
  use Application

  def start(_type, _args) do
    api = HelloRest.Api
    api_opts = %{ store: :default }
    api_port = Application.get_env(:hello_rest, :port, 4000)
    
    Supervisor.start_link([
      Plug.Adapters.Cowboy.child_spec(:http, api, api_opts, port: api_port)
    ], strategy: :one_for_one)
  end
end
