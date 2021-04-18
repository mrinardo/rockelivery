defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Update

  describe "call/1" do
    setup do
      id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

      {:ok, id: id}
    end

    test "when the user id is found and parameters are valid, update the user", %{id: id} do
      insert(:user, %{id: id})

      params_update = %{"id" => id, "name" => "João"}

      response = Update.call(params_update)

      assert {:ok, %User{name: "João"}} = response
    end

    test "when the user id is not found, returns an error" do
      params_update = %{"id" => "00000000-0000-0000-0000-000000000000"}

      response = Update.call(params_update)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end

    test "when parameters are not valid, returns errors", %{id: id} do
      insert(:user, %{id: id})

      params_update = %{"id" => id, "age" => 10, "password" => "123"}

      response = Update.call(params_update)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
