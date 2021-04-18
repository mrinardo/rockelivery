defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when the user id is found, returns the user" do
      id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

      insert(:user, %{id: id})

      response = Get.by_id(id)

      assert {:ok, %User{}} = response
    end

    test "when the user id is not found, returns an error" do
      id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

      response = Get.by_id(id)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
