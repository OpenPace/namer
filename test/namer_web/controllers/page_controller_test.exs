defmodule NamerWeb.PageControllerTest do
  use NamerWeb.ConnCase

  test "GET /namer", %{conn: conn} do
    conn = get(conn, "/namer")
    assert html_response(conn, 200) =~ "Connect to Strava"
  end
end
