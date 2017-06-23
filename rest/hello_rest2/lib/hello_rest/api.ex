defmodule HelloRest.Api do
  use Ewebmachine.Builder.Resources
  resources_plugs

  resource "/hello/:name" do
    %{ name: name, store: :store }
  after
    allowed_methods do: ["GET", "HEAD", "PUT", "DELETE"]

    content_types_accepted do: ['text/plain': :from_text]
    content_types_provided do: ['text/plain': :to_text]

    defh to_text(conn, state) do
      value = HelloStore.get(state.store, state.name)
      {"Are you #{value} ?\n", conn, state}
    end

    defh from_text(conn, state) do
      body = Ewebmachine.fetch_req_body(conn, []) |> Ewebmachine.req_body
      HelloRest.Store.put(state.store, state.name, body)
      {true, conn, state}
    end

    defh delete_resource(conn, state) do
      HelloRest.Store.delete(state.store, state.name)
      {true, conn, state}
    end
  end
end
