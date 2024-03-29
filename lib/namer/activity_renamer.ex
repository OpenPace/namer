defmodule Namer.ActivityRenamer do
  @moduledoc """
  This module renames activities
  """
  require Logger

  alias Namer.Accounts
  alias Namer.DescriptionGenerator
  alias Namer.NameGenerator
  alias Strava.{Activities, Client, DetailedActivity}

  import Strava.RequestBuilder

  def rename(user, activity_id) when is_binary(activity_id) or is_integer(activity_id) do
    with {:ok, user} <- Accounts.refresh_token(user),
         {:ok, activity} <- fetch_activity(user, activity_id) do
      rename(user, activity)
    else
      error -> error
    end
  end

  def rename(_, %DetailedActivity{manual: true} = activity), do: activity

  def rename(user, %DetailedActivity{} = activity) do
    if activity.device_name =~ "Strava" do # Skip all Strava Apps
      activity
    else
      rename_activity(user, activity)
    end
  end

  defp rename_activity(user, activity) do
    name = NameGenerator.generate_name(user, activity)
    description = DescriptionGenerator.generate_description(user, activity)
    attrs = %{name: name, description: description}

    Logger.info("Renaming #{activity.id}: #{name}")

    update_activity(user, activity, attrs)
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

  defp update_activity(user, activity, attrs) do
    user
    |> strava_client()
    |> Client.put("/activities/#{activity.id}", attrs)
    |> decode(%DetailedActivity{})
  end
end
