defmodule Namer.RenamerJob do
  @moduledoc """
  Basic job to retry naming 3 times.
  """
  require Logger

  alias Namer.Accounts
  alias Namer.ActivityRenamer

  def perform(strava_uid, activity_id, retry \\ 3)
  def perform(_, _, 0), do: :ignore
  def perform(strava_uid, activity_id, retry) do
    Logger.info("Starting job for #{strava_uid} for activity #{activity_id}")

    :timer.sleep(:timer.minutes(1))

    with {:ok, user} <- get_user(strava_uid),
         {:ok, _} <- ActivityRenamer.rename(user, activity_id) do
      :ok
    else
      _ ->
        :timer.sleep(:timer.minutes(1))
        perform(strava_uid, activity_id, retry - 1)
    end
  end

  defp get_user(strava_uid) do
    case Accounts.get_user_by_uid(strava_uid) do
      nil -> :error
      user -> {:ok, user}
    end
  end
end
