defmodule HelloRest.App do
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    api = HelloRest.Api
    api_opts = %{ store: :default }
    api_port = Application.get_env(:hello_rest, :port, 4000)
    
    Supervisor.start_link([
      Plug.Adapters.Cowboy.child_spec(:http, api, api_opts, port: api_port),
      worker(HelloRest.Store, [:store])
    ], strategy: :one_for_one)
  end
end
