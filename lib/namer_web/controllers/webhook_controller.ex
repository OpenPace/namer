defmodule NamerWeb.WebhookController do
  use NamerWeb, :controller

  @moduledoc """
  Controller to handle the webhooks from Strava
  """

  alias Namer.Accounts
  alias Namer.ActivityRenamer

  @challenge_token Application.get_env(:strava, :webhook_challenge)

  plug :validate_token when action in [:challenge]

  def webhook(conn, %{"aspect_type" => "create", "object_type" => "activity"} = params) do
    user = Accounts.get_user_by_uid(params["owner_id"])

    Task.start(fn ->
      :timer.sleep(:timer.minutes(2))
      ActivityRenamer.rename(user, params["object_id"])
    end)
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
end
