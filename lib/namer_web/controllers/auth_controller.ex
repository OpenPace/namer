defmodule NamerWeb.AuthController do
  use NamerWeb, :controller

  def request(conn, %{"provider" => provider}) do
    redirect(conn, external: authorize_url!(provider))
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)
    _user = get_athlete!(client)
    conn
    |> put_flash(:error, "Authentication failed for #{provider}")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp authorize_url!("strava") do
    scope = "read,activity:read_all,activity:write"
    Strava.Auth.authorize_url!(scope: scope)
  end

  defp get_token!("strava", code) do
    Strava.Auth.get_token!(code: code, grant_type: "authorization_code")
  end

  defp get_athlete!(client) do
    Strava.Auth.get_athlete!(client)
  end
end
