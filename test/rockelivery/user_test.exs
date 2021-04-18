defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, returns a changeset for a new record" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Maurício"}, valid?: true} = response
    end

    test "when there are any error, returns an invalid changeset" do
      params = build(:user_params, %{age: 15, password: "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when all params are valid, returns a changeset for updating a record" do
      params = build(:user_params)

      params_update = %{name: "João"}

      response =
        params
        |> User.changeset()
        |> User.changeset(params_update)

      assert %Changeset{changes: %{name: "João"}, valid?: true} = response
    end

    test "when there are any error, returns an invalid changeset" do
      params = build(:user_params, %{age: 15, password: "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
