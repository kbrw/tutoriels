defmodule Hello.Sup do
  import Supervisor.Spec

  def start_link do
    store_name = :store
    store_spec = worker(Hello.Store, [store_name])
    cli_spec = worker(Hello.Cli, [
      Application.get_env(:hello, :listeners),
      Application.get_env(:hello, :port),
      store_name
    ])
    
    Supervisor.start_link([store_spec, cli_spec], strategy: :one_for_one)
  end
end
