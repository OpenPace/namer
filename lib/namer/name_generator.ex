defmodule Namer.NameGenerator do
  @moduledoc """
  This module creates names for a user and activity.
  """

  alias Namer.DistanceFormatter
  alias Namer.DurationFormatter
  alias Namer.EmojiFormatter

  @branding_text "Renamed with openpace.co/namer"

  def generate_name(user, activity) do
    parts = [
      emoji(user, activity),
      name(user, activity)
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

  defp emoji(%{user_prefs: %{emoji: true}}, activity) do
    EmojiFormatter.format(activity.type)
  end
  defp emoji(_, _), do: nil

  defp name(_, %{distance: distance} = activity) when distance == 0 do
    duration = DurationFormatter.format(activity.moving_time)
    "#{duration} #{activity.type}"
  end
  defp name(%{user_prefs: %{imperial: imperial}}, activity) do
    distance = DistanceFormatter.format(activity.distance, imperial: imperial)
    "#{distance} #{activity.type}"
  end

  defp is_blank(str), do: is_nil(str) || String.trim(str) == ""

  defp stripped_description(description) do
    String.replace(description, @branding_text, "")
  end
end
