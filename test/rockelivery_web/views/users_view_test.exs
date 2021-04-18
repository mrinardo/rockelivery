defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  # não tem describe pq a view só tem a render
  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               address: "Rua 0",
               age: 35,
               cep: "01234567",
               cpf: "12345678910",
               email: "mauricio@m.com.br",
               id: "8bc5419c-b47d-4de2-9024-8436444f4b51",
               inserted_at: nil,
               name: "Maurício",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } ==
             response
  end
end
