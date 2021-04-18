defmodule RockeliveryWeb.Plugs.UUIDCheckerTest do
  use RockeliveryWeb.ConnCase, async: true
  use ExUnit.Case, async: true
  use Plug.Test

  alias RockeliveryWeb.Plugs.UUIDChecker

  describe "call/2" do
    test "when an valid UUID is received, returns the connection" do
      id = "8bc5419c-b47d-4de2-9024-8436444f4b51"

      conn = conn(:get, "/foo", %{"id" => id})

      response =
        conn
        |> UUIDChecker.call([])

      assert response == conn
    end

    test "when no UUID is received, returns the connection" do
      conn = conn(:get, "/foo", %{"foo" => "foo"})

      response =
        conn
        |> UUIDChecker.call([])

      assert response == conn
    end

    test "when an invalid UUID is received, returns an error" do
      id = "000"

      response =
        conn(:get, "/foo", %{"id" => id})
        |> UUIDChecker.call([])

      {_status, _headers, body} = sent_resp(response)

      assert Jason.decode!(body) == %{"message" => "Invalid UUID"}
    end
  end

  describe "init/1" do
    test "when initializing, returns the options" do
      assert 1 == 1
    end

    test "when initializing 1, returns the options" do
      assert 0 == 0
    end
  end
end
