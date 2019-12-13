defmodule Namer.NameGenerator do
  @moduledoc """
  This module creates names for a user and activity.
  """

  import NamerWeb.Gettext

  alias Namer.DistanceFormatter
  alias Namer.DurationFormatter
  alias Namer.EmojiFormatter

  def generate_name(user, activity) do
    parts = [
      emoji(user, activity),
      distance(user, activity),
      duration(user, activity),
      relative_time(user, activity),
      activity.type
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
      branding_text()
    ]
    |> Enum.reject(&is_blank/1)
    |> Enum.join(" - ")
  end
  defp description(_, activity), do: activity.description

  defp emoji(%{user_prefs: %{emoji: true}}, activity) do
    EmojiFormatter.format(activity.type)
  end
  defp emoji(_, _), do: nil

  defp distance(_, %{distance: distance}) when distance == 0, do: nil
  defp distance(%{user_prefs: %{imperial: imperial}}, activity) do
    DistanceFormatter.format(activity.distance, imperial: imperial)
  end

  defp duration(_, %{distance: distance} = activity) when distance == 0 do
    DurationFormatter.format(activity.moving_time)
  end
  defp duration(_, _), do: nil

  defp relative_time(_, %{start_date_local: timestamp}) do
    case timestamp.hour do
      x when x >= 5 and x < 12 -> gettext("Morning") # 5am until 12 noon
      x when x >= 12 and x < 17 -> gettext("Afternoon") # noon until 5pm
      x when x > 17 and x < 21 -> gettext("Evening") # 5pm until 9pm
      _ -> gettext("Night") # After 9pm
    end
  end

  defp is_blank(str), do: is_nil(str) || String.trim(str) == ""

  defp stripped_description(description) when is_nil(description), do: ""
  defp stripped_description(description) do
    String.replace(description, branding_text(), "")
  end

  defp branding_text() do
    gettext("Renamed with openpace.co/namer")
  end
end
