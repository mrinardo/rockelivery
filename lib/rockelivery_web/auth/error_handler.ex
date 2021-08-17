defmodule RockeliveryWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  # O erro aqui ocorre no fluxo do Plug, antes de chegar aos controllers
  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    Conn.send_resp(conn, 401, body)
  end
end
