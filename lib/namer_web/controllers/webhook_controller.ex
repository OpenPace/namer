defmodule NamerWeb.WebhookController do
  use NamerWeb, :controller

  @moduledoc """
  Controller to handle the webhooks from Strava
  """

  alias Namer.Accounts
  alias Namer.Logger
  alias Namer.RenamerJob

  @challenge_token Application.get_env(:strava, :webhook_challenge)

  plug :validate_token when action in [:challenge]
  plug :log_event

  def webhook(conn, %{"aspect_type" => "create", "object_type" => "activity"} = params) do
    Task.start(fn -> process_event(params) end)
    render(conn, "success.json")
  end

  def webhook(conn, %{"updates" => %{"authorized" => "false"}, "owner_id" => id}) do
    user = Accounts.get_user_by_uid(id)
    Accounts.delete_user(user)
    render(conn, "success.json")
  end

  def webhook(conn, _), do: render(conn, "success.json")

  def challenge(conn, %{"hub.challenge" => challenge}) do
    render(conn, "challenge.json", challenge: challenge)
  end

  defp validate_token(conn, _) do
    token = conn.params["hub.verify_token"]
    if token == @challenge_token do
      conn
    else
      conn
      |> render_bad_request()
      |> halt()
    end
  end

  defp render_bad_request(conn)  do
    conn
    |> put_status(:bad_request)
    |> render("400.json")
  end

  defp process_event(%{"owner_id" => user_id, "object_id" => activity_id}) do
    RenamerJob.perform(user_id, activity_id)
  end
  defp process_event(_), do: nil

  defp log_event(conn, _)  do
    body = Jason.encode!(conn.params)
    Logger.log_webhook_event(%{provider: "strava", body: body})
    conn
  end
end
