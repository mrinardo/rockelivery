defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    # IO.inspect(params, label: "DEPURANDO VALOR:::")

    conn
    |> put_status(:ok)
    |> text("Welcome :)")

    # |> json(%{message: "valor"})
  end
end
