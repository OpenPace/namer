defmodule Namer.NameGenerator do
  @moduledoc """
  This module creates names for a user and activity.
  """

  alias Namer.ActivityTypeFormatter
  alias Namer.DistanceFormatter
  alias Namer.DurationFormatter
  alias Namer.EmojiFormatter

  @branding_text "Renamed with openpace.co/namer"

  def generate_name(%{user_prefs: %{emoji: emoji, imperial: imperial}}, activity) do
    parts = [
      EmojiFormatter.format(activity, emoji: emoji),
      DistanceFormatter.format(activity, imperial: imperial),
      DurationFormatter.format(activity),
      relative_time(nil, activity),
      ActivityTypeFormatter.format(activity.type)
    ]

    parts
    |> Enum.reject(&is_blank/1)
    |> Enum.join(" ")
  end

  def generate_description(user, activity) do
    description(user, activity)
  end

  defp description(%{user_prefs: %{branding: true}}, activity) do
    [
      stripped_description(activity.description),
      @branding_text
    ]
    |> Enum.reject(&is_blank/1)
    |> Enum.join(" - ")
  end
  defp description(_, activity), do: activity.description

  defp relative_time(_, %{start_date_local: timestamp}) do
    case timestamp.hour do
      x when x >= 5 and x < 12 -> "Morning" # 5am until 12 noon
      x when x >= 12 and x < 17 -> "Afternoon" # noon until 5pm
      x when x > 17 and x < 21 -> "Evening" # 5pm until 9pm
      _ -> "Night" # After 9pm
    end
  end

  defp is_blank(str), do: is_nil(str) || String.trim(str) == ""

  defp stripped_description(description) when is_nil(description), do: ""
  defp stripped_description(description) do
    String.replace(description, @branding_text, "")
  end
end
