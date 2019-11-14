defmodule Namer.NameGenerator do
  @emoji_map %{
    "AlpineSki" => "⛷️", # https://emojipedia.org/skier/
    "BackcountrySki" => "⛷", # https://emojipedia.org/skier/
    "Canoeing" => "🛶", # https://emojipedia.org/canoe/
    "Crossfit" => nil,
    "EBikeRide" => "🚴", # https://emojipedia.org/bicyclist/
    "Elliptical" => nil,
    "Golf" => "🏌️️", # https://emojipedia.org/golfer/
    "Handcycle" => nil,
    "Hike" => "🥾", # https://emojipedia.org/hiking-boot/
    "IceSkate" => "⛸️", # https://emojipedia.org/ice-skate/
    "InlineSkate" => nil,
    "Kayaking" => nil,
    "Kitesurf" => nil,
    "NordicSki" => nil,
    "Ride" => "🚴", # https://emojipedia.org/bicyclist/
    "RockClimbing" => nil,
    "RollerSki" => nil,
    "Rowing" => "🚣", # https://emojipedia.org/rowboat/
    "Run" => "🏃", # https://emojipedia.org/runner/
    "Sail" => "⛵", # https://emojipedia.org/sailboat/
    "Skateboard" => "🛹", # https://emojipedia.org/skateboard/
    "Snowboard" => "🏂", # https://emojipedia.org/snowboarder/
    "Snowshoe" => nil,
    "Soccer" => "⚽", # https://emojipedia.org/soccer-ball/
    "StairStepper" => nil,
    "StandUpPaddling" => nil,
    "Surfing" => "🏄", # https://emojipedia.org/surfer/
    "Swim" => "🏊", # https://emojipedia.org/swimmer/
    "Velomobile" => nil,
    "VirtualRide" => "🚴", # https://emojipedia.org/bicyclist/
    "VirtualRun" => nil,
    "Walk" => "🚶", # https://emojipedia.org/pedestrian/
    "WeightTraining" => "🏋️", # https://emojipedia.org/weight-lifter/
    "Wheelchair" => nil,
    "Windsurf" => nil,
    "Workout" => nil,
    "Yoga" => "🧘" # https://emojipedia.org/person-in-lotus-position/
  }

  def generate_name(user, activity) do
    parts = [
      emoji(user, activity),
      name(user, activity)
    ]

    parts
    |> Enum.reject(&is_nil/1)
    |> Enum.join(" ")
  end

  def generate_description(user, activity) do
    description(user, activity)
  end

  defp description(%{user_prefs: %{branding: true}}, activity) do
    [
      activity.description,
      "Renamed with openpace.co/namer"
    ]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(" - ")
  end
  defp description(_, activity), do: activity.description

  defp emoji(%{user_prefs: %{emoji: true}}, activity) do
    @emoji_map[activity.type]
  end
  defp emoji(_, _), do: nil

  defp name(_, %{distance: distance} = activity) when distance == 0 do
    "#{format_time(activity.moving_time)} #{activity.type}"
  end
  defp name(_, activity), do: activity.type

  defp format_time(t) do
    minutes = trunc(rem(t, 60 * 60) / 60)
    hours = trunc(t / (60 * 60))

    if hours > 0 do
      "#{hours}hr #{pad_num(minutes)}min"
    else
      "#{minutes}min"
    end
  end

  defp pad_num(x) when x < 10, do: "0#{x}"
  defp pad_num(x), do: "#{x}"
end
