defmodule NamerWeb.Plug.Auth do
  import Plug.Conn

  @moduledoc """
  This module defines the auth plug which does one of two things:

  1. Pulls the user from the current session
  2. Creates a new guest user

  All visitors are a user which allows us to collect user preferences
  before they actually sign up.
  """

  alias Namer.Accounts
  alias NamerWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller

  def init(_), do: nil

  def call(conn, _) do
    case get_session(conn, :user_id) do
      nil -> redirect_to_home(conn)
      user_id -> set_user(conn, user_id)
    end
  end

  def redirect_to_home(conn) do
    conn
    |> Controller.redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end

  defp set_user(conn, user_id) do
    user = Accounts.get_user!(user_id)

    conn
    |> assign(:current_user, user)
  end
end
