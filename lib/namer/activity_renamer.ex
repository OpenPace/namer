defmodule Namer.ActivityRenamer do
  @moduledoc """
  This module renames activities
  """
  require Logger

  alias Namer.Accounts
  alias Namer.NameGenerator
  alias Strava.{Activities, Client, DetailedActivity}

  import Strava.RequestBuilder

  def rename(user, activity_id) when is_binary(activity_id) or is_integer(activity_id) do
    case fetch_activity(user, activity_id) do
      {:ok, activity} -> rename(user, activity)
      error -> error
    end
  end

  def rename(user, activity) do
    name = NameGenerator.generate_name(user, activity)
    description = NameGenerator.generate_description(user, activity)
    attrs = %{name: name, description: description}

    Logger.info("Renaming #{activity.id}: #{name}")

    with {:ok, activity} <- update_activity(user, activity, attrs),
         {:ok, activity} <- confirm_name(activity.name, activity) do

      Logger.info("Renamed #{activity.id}: #{name}")
      {:ok, activity}
    else
      _ -> {:error}
    end
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

  defp confirm_name(name, activity) do
    if name == activity.name do
      {:ok, activity}
    else
      {:error}
    end
  end
end
