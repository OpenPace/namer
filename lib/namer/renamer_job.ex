defmodule Namer.RenamerJob do
  @moduledoc """
  Basic job to retry naming 10 times.
  """
  require Logger

  alias Namer.ActivityRenamer

  def perform(user, activity_id, retry \\ 10)
  def perform(_, _, 0), do: :ignore
  def perform(user, activity_id, retry) do
    Logger.info("Starting job for #{user.id} for activity #{activity_id}")

    case ActivityRenamer.rename(user, activity_id) do
      {:error} ->
        :timer.sleep(:timer.minutes(1))
        perform(user, activity_id, retry - 1)
      _ -> :ok
    end
  end
end
