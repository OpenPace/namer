defmodule Namer.NameChecker do
  @moduledoc """
  This module checks the names of strava activities

  Examples:
  * Morning Run
  * Lunch Ride
  * Evening Activity
  * Night Run
  """

  @activity_times ~w(morning lunch afternoon evening night)
  @activity_names ~w(run ride swim hike walk activity)

  alias Strava.DetailedActivity

  @doc """
  Returns true if the activity is a default strava name


  ## Examples

    iex> strava_default?(%DetailedActivity{name: "Morning Run})
    true

    iex> strava_default?(%DetailedActivity{name: "Lighthouse Jog"})
    false
  """
  def strava_default?(%DetailedActivity{name: name}) when is_binary(name) do
    parts = name
    |> String.downcase()
    |> String.split()

    length(parts) == 2 &&
      Enum.member?(@activity_times, List.first(parts)) &&
      Enum.member?(@activity_names, List.last(parts))
  end
  def strava_default?(_), do: false
end
