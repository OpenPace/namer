defmodule Mix.Tasks.Setup.Webhooks do
  use Mix.Task

  @moduledoc """
  Creates the required webhooks for strava to push activities.

  ## Examples

  cmd> mix setup.webhook
  Created strava webhook subscription
  """

  alias HTTPoison.Response

  @doc false
  def run(_) do
    Mix.Task.run("app.start")
    create_strava_subscription()
    Mix.shell.info("Created strava webhook subscription")
  end

  defp create_strava_subscription do
    url = "https://api.strava.com/api/v3/push_subscriptions"
    form = [
      client_id: Application.get_env(:strava, :client_id),
      client_secret: Application.get_env(:strava, :client_secret),
      callback_url: "https://openpace.co/namer/webhook",
      verify_token: Application.get_env(:strava, :webhook_challenge)
    ]

    {:ok, %Response{status_code: 201}} = HTTPoison.post(url, {:form, form})
  end
end
