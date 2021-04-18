defmodule RockeliveryWeb.WelcomeControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  alias RockeliveryWeb.WelcomeController

  describe "index/2" do
    test "outputs welcome message", %{conn: conn} do
      response = WelcomeController.index(conn, [])
      assert text_response(response, :ok) == "Welcome :)"
    end
  end
end
