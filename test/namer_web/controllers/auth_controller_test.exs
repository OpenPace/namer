defmodule NamerWeb.AuthControllerTest do
  use NamerWeb.ConnCase

  describe "GET #request" do
    test "redirects to strava", %{conn: conn} do
      conn = get(conn, Routes.auth_path(conn, :request, "strava"))
      assert redirected_to(conn) =~ ~r/https:\/\/www.strava.com/
    end
  end
end
