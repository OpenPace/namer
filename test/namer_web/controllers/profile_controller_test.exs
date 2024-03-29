defmodule NamerWeb.ProfileControllerTest do
  use NamerWeb.ConnCase

  describe "GET /profile" do
    @tag :no_user
    test "without a user", %{conn: conn} do
      conn = get(conn, "/profile")
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
