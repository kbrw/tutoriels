defmodule HelloRest.Api do
  use Ewebmachine.Builder.Resources
  resources_plugs

  resource "/hello/:name" do %{ state | name: name} after
    allowed_methods do: ["GET", "HEAD", "PUT", "DELETE"]

    content_types_accepted do: ['text/plain': :from_text]
    content_types_provided do: ['text/plain': :to_text]
    
    defh to_text(conn, state) do
      {"Hello #{state.name} !!!\n", conn, state}
    end

    defh from_text(conn, state) do
      body = Ewebmachine.fetch_req_body(conn, []) |> Ewebmachine.req_body
      IO.puts("PUT #{body} in #{state.store}")
      {true, conn, state}
    end

    defh delete_resource(conn, state) do
      {true, conn, state}
    end
  end
end
