defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  setup do
    id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

    {:ok, id: id}
  end

  describe "create/2" do
    test "when all parameters are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 35,
        "address" => "Rua 0",
        "cep" => "01234567",
        "cpf" => "12345678910",
        "email" => "mauricio@m.com.br",
        "password" => "123456",
        "name" => "Maurício"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua 0",
                 "age" => 35,
                 "cep" => "01234567",
                 "cpf" => "12345678910",
                 "email" => "mauricio@m.com.br",
                 "id" => _id,
                 "name" => "Maurício"
               }
             } = response
    end

    test "when there is any error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Maurício"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when the user exists, deletes the user", %{conn: conn, id: id} do
      insert(:user, %{id: id})

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when the user does not exist, returns an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when the user id is found, returns the user", %{conn: conn, id: id} do
      insert(:user, %{id: id})

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert response == %{
               "user" => %{
                 "address" => "Rua 0",
                 "age" => 35,
                 "cep" => "01234567",
                 "cpf" => "12345678910",
                 "email" => "mauricio@m.com.br",
                 "id" => "8bc5419c-b47d-4de2-9024-8436444f4b51",
                 "name" => "Maurício"
               }
             }
    end

    test "when the user id is not found, returns an error", %{conn: conn, id: id} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert response == %{"message" => "User not found!"}
    end
  end

  describe "update/2" do
    test "when the user id is found and the parameters are valid, update the user", %{
      conn: conn,
      id: id
    } do
      params = %{id: id, name: "João"}

      insert(:user, %{id: id})

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:ok)

      assert response == %{
               "user" => %{
                 "address" => "Rua 0",
                 "age" => 35,
                 "cep" => "01234567",
                 "cpf" => "12345678910",
                 "email" => "mauricio@m.com.br",
                 "id" => "8bc5419c-b47d-4de2-9024-8436444f4b51",
                 "name" => "João"
               }
             }
    end

    test "when the user is not found, returns an error", %{conn: conn, id: id} do
      params = %{id: id, name: "João"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:not_found)

      assert response == %{"message" => "User not found!"}
    end

    test "when there are invalid parameters, returns the errors", %{conn: conn, id: id} do
      params = %{id: id, age: 10, cpf: ""}

      insert(:user, %{id: id})

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:bad_request)

      assert response == %{
               "message" => %{
                 "age" => ["must be greater than or equal to %18"],
                 "cpf" => ["can't be blank"]
               }
             }
    end
  end
end
