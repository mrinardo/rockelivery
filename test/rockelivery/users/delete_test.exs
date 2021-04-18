defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Delete

  describe "call/1" do
    setup do
      id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

      {:ok, id: id}
    end

    test "when the user id is found, delete the user", %{id: id} do
      insert(:user, %{id: id})

      response = Delete.call(id)

      assert {:ok, %User{}} = response
    end

    test "when the user id is not found, returns an error", %{id: id} do
      response = Delete.call(id)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
