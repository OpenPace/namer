defmodule NamerWeb.ProfileController do
  use NamerWeb, :controller

  alias Namer.Accounts

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    changeset = Accounts.change_user(current_user)
    render(conn, "index.html", changeset: changeset)
  end

  def update(conn, %{"user" => user_params}, current_user) do
    case Accounts.update_user(current_user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Your preferences have been updated"))
        |> redirect(to: Routes.profile_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
