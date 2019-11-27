defmodule Namer.RenamerJob do
  @moduledoc """
  Basic job to retry naming 3 times.
  """

  alias Namer.ActivityRenamer

  def perform(user, activity_id, retry \\ 3)
  def perform(_, _, 0), do: :ignore
  def perform(user, activity_id, retry) do
    case ActivityRenamer.rename(user, activity_id) do
      {:error} ->
        :timer.sleep(:timer.minutes(1))
        perform(user, activity_id, retry - 1)
      _ -> :ok
    end
  end
end
