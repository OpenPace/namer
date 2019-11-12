defmodule NamerWeb.ProfileControllerTest do
  use NamerWeb.ConnCase

  test "GET /namer", %{conn: conn} do
    conn = get(conn, "/namer/profile")
    assert html_response(conn, 200) =~ "Profile"
  end
end
