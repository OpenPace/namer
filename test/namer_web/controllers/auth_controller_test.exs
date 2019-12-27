defmodule NamerWeb.AuthControllerTest do
  use NamerWeb.ConnCase

  describe "GET #request" do
    test "redirects to strava", %{conn: conn} do
      conn = get(conn, Routes.auth_path(conn, :request, "strava"))
      assert redirected_to(conn) =~ ~r/https:\/\/www.strava.com/
    end
  end

  describe "POST #callback" do
  end

  describe "DELETE #delete" do
    test "signs out the user", %{conn: conn} do
      conn = delete(conn, Routes.auth_path(conn, :delete))

      assert get_session(conn, :user_id) == nil
    end
  end
end
