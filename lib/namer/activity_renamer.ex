defmodule Namer.ActivityRenamer do

  alias Namer.Accounts
  alias Namer.NameGenerator
  alias Strava.{Activities, Client}

  def rename(user, activity_id) do
    {:ok, activity} = fetch_activity(user, activity_id)
    update_activity(user, activity)
  end

  defp fetch_activity(user, activity_id) do
    user
    |> strava_client()
    |> Activities.get_activity_by_id(activity_id)
  end

  defp strava_client(user) do
    Client.new(user.access_token,
      refresh_token: user.refresh_token,
      token_refreshed: &Accounts.update_user(user, Map.from_struct(&1.token))
    )
  end

  defp update_activity(user, activity) do
    attrs = %{
      name: NameGenerator.generate_name(user, activity),
      description: NameGenerator.generate_description(user, activity)
    }

    user
    |> strava_client()
    |> Client.put("/activities/#{activity.id}", attrs)
  end
end