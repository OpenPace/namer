defmodule NamerWeb.AuthController do
  use NamerWeb, :controller

  alias Namer.Accounts
  alias Namer.Reporter

  def request(conn, _) do
    redirect(conn, external: authorize_url!())
  end

  def callback(conn, %{"code" => code}) do
    client = get_token!(code)
    athlete = Strava.Auth.get_athlete!(client)

    case Accounts.get_user_by_uid(athlete.id) do
      nil -> create_user_and_redirect(conn, client, athlete)
      user -> sign_in_and_redirect(conn, client, user)
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp authorize_url!() do
    scope = "read,activity:read_all,activity:write"
    Strava.Auth.authorize_url!(scope: scope)
  end

  defp get_token!(code) do
    Strava.Auth.get_token!(code: code, grant_type: "authorization_code")
  end

  defp token_attrs(%{token: token}) do
    %{
      access_token: token.access_token,
      refresh_token: token.refresh_token
    }
  end

  defp user_attrs(client, athlete) do
    attrs = %{
      avatar: athlete.profile,
      name: "#{athlete.firstname} #{athlete.lastname}",
      strava_uid: "#{athlete.id}",
      user_prefs: %{
        imperial: athlete.measurement_preference == "feet"
      }
    }
    attrs |> Map.merge(token_attrs(client))
  end

  defp sign_in_and_redirect(conn, client, user) do
    case Accounts.update_user(user, token_attrs(client)) do
      {:ok, _} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.profile_path(conn, :index))
      _ ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp create_user_and_redirect(conn, client, athlete) do
    user_params = user_attrs(client, athlete)

    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Reporter.report_new_user(user)

        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.profile_path(conn, :index))
      _ ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
