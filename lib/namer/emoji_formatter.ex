defmodule Namer.EmojiFormatter do
  @moduledoc """
  This module returns an emoji for an activity type
  """

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

  def format(%{type: type}, [emoji: true]) do
    @emoji_map[type]
  end
  def format(_, _), do: nil
end
