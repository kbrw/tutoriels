defmodule Hello.Sup do
  import Supervisor.Spec

  def start_link do
    Supervisor.start_link([
      worker(Hello.Store, [])
    ], strategy: :one_for_one)
  end
end
