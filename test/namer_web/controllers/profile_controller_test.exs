defmodule NamerWeb.ProfileControllerTest do
  use NamerWeb.ConnCase

  describe "GET /namer/profile" do
    test "without a user", %{conn: conn} do
      conn = get(conn, "/namer/profile")
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
