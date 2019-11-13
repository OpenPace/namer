defmodule NamerWeb.AuthController do
  use NamerWeb, :controller

  alias Namer.Accounts

  def request(conn, _) do
    redirect(conn, external: authorize_url!())
  end

  def callback(conn, %{"code" => code}) do
    client = get_token!(code)
    user_params = user_attrs(client)

    case Accounts.get_user_by_uid(user_params[:strava_uid]) do
      nil -> create_user_and_redirect(conn, user_params)
      user -> sign_in_and_redirect(conn, user)
    end
  end

  defp authorize_url!() do
    scope = "read,activity:read_all,activity:write"
    Strava.Auth.authorize_url!(scope: scope)
  end

  defp get_token!(code) do
    Strava.Auth.get_token!(code: code, grant_type: "authorization_code")
  end

  defp user_attrs(%{token: token} = client) do
    user = Strava.Auth.get_athlete!(client)
    %{
      avatar: user.profile,
      access_token: token.access_token,
      name: "#{user.firstname} #{user.lastname}",
      refresh_token: token.refresh_token,
      strava_uid: "#{user.id}"
    }
  end

  defp sign_in_and_redirect(conn, user) do
    conn
    |> put_session(:user_id, user.id)
    |> redirect(to: Routes.profile_path(conn, :index))
  end

  defp create_user_and_redirect(conn, user_params) do
    case Accounts.create_user(user_params) do
      {:ok, user} -> sign_in_and_redirect(conn, user)
      _ ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
