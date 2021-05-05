defmodule Namer.DescriptionGenerator do
  @moduledoc """
  This module converts an activity into Morning, Afternoon, Evening, and Night
  """

  @branding_text "Renamed with openpace.co/namer"

  def generate_description(%{user_prefs: %{branding: true}} = user, %{description: description} = activity) do
    [
      stripped_description(description),
      @branding_text,
      best_line_hashtag(user, activity)
    ]
    |> Enum.reject(&is_blank/1)
    |> Enum.join(" - ")
  end

  def generate_description(_, %{description: description}), do: description

  def generate_description(_, _), do: nil

  ## Different lines
  # - #PaceMap or #SpeedMap: Higher speed/lower pace will be a darker blue.
  # - #HeartrateMap: Higher heart rate will be a darker red.
  # - #Elevationmap: Lower absolute elevation will be black and higher elevation will be yellow.
  # - #GradientMap: Descents will be yellow and inclines will be red.
  # - #PowerMap: Higher power will be darker purple. Please be aware this map treatment is not available for activities with estimated power.
  # - #TimeMap: Longer elapsed time will be a darker red.
  # - #TemperatureMap: Higher temperatures will be a darker red.

  # Only premium users can use the hashtags
  def best_line_hashtag(%{premium: false}, _), do: nil

  def best_line_hashtag(_user, activity) do
    cond do
      activity.total_elevation_gain && activity.total_elevation_gain > 500 ->
        "#gradientmap"
      activity.elev_high && (activity.elev_high - activity.elev_low) > 300 ->
        "#elevationmap"
      activity.average_watts ->
        "#powermap"
      true ->
        "#pacemap"
    end
  end

  defp is_blank(str), do: is_nil(str) || String.trim(str) == ""

  defp stripped_description(description) when is_nil(description), do: ""

  defp stripped_description(description) do
    String.replace(description, @branding_text, "")
  end
end
