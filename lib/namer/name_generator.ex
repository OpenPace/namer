defmodule Namer.NameGenerator do
  @moduledoc """
  This module creates names for a user and activity.
  """

  alias Namer.ActivityTypeFormatter
  alias Namer.DistanceFormatter
  alias Namer.DurationFormatter
  alias Namer.EmojiFormatter
  alias Namer.RelativeTimeFormatter

  def generate_name(%{user_prefs: %{emoji: emoji, imperial: imperial}}, activity) do
    parts = [
      EmojiFormatter.format(activity, emoji: emoji),
      DistanceFormatter.format(activity, imperial: imperial),
      DurationFormatter.format(activity),
      RelativeTimeFormatter.format(activity),
      ActivityTypeFormatter.format(activity.type)
    ]

    parts
    |> Enum.reject(&is_blank/1)
    |> Enum.join(" ")
  end

  defp is_blank(str), do: is_nil(str) || String.trim(str) == ""
end
