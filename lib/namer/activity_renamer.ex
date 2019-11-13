defmodule Namer.ActivityRenamer do

  alias Namer.Accounts
  alias Strava.{Activities, Client}

  def rename(user, activity_id) do
    {:ok, _activity} = fetch_activity(user, activity_id)
  end

  def fetch_activity(user, activity_id) do
    user
    |> strava_client()
    |> Activities.get_activity_by_id(activity_id)
  end

  def strava_client(user) do
    Client.new(user.access_token,
      refresh_token: user.refresh_token,
      token_refreshed: &Accounts.update_user(user, Map.from_struct(&1.token))
    )
  end

  def update_activity(user, activity) do
    user
    |> strava_client()
    |> Activities.update_activity_by_id(activity.id)
  end
end
