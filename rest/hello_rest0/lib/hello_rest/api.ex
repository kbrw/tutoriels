defmodule HelloRest.Api do
  use Ewebmachine.Builder.Resources
  resources_plugs

  resource "/hello/:name" do %{name: name} after
    content_types_provided do: ['text/plain': :to_text]
    
    defh to_text(conn, state) do
      {"Hello #{state.name} !!!\n", conn, state}
    end
  end
end
