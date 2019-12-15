defmodule Namer.ActivityTypeFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.ActivityTypeFormatter

  test "format/1" do
    assert ActivityTypeFormatter.format("AlpineSki") == "Ski"
    assert ActivityTypeFormatter.format("BackcountrySki") == "Backcountry Ski"
    assert ActivityTypeFormatter.format("Canoeing") == "Canoeing"
    assert ActivityTypeFormatter.format("Crossfit") == "Crossfit"
    assert ActivityTypeFormatter.format("EBikeRide") == "Bike"
    assert ActivityTypeFormatter.format("Elliptical") == "Elliptical"
    assert ActivityTypeFormatter.format("Golf") == "Golf"
    assert ActivityTypeFormatter.format("Handcycle") == "Handcycle"
    assert ActivityTypeFormatter.format("Hike") == "Hike"
    assert ActivityTypeFormatter.format("IceSkate") == "Ice Skate"
    assert ActivityTypeFormatter.format("InlineSkate") == "Inline Skate"
    assert ActivityTypeFormatter.format("Kayaking") == "Kayaking"
    assert ActivityTypeFormatter.format("Kitesurf") == "Kitesurf"
    assert ActivityTypeFormatter.format("NordicSki") == "Nordic Ski"
    assert ActivityTypeFormatter.format("Ride") == "Ride"
    assert ActivityTypeFormatter.format("RockClimbing") == "Rock Climbing"
    assert ActivityTypeFormatter.format("RollerSki") == "Roller Ski"
    assert ActivityTypeFormatter.format("Rowing") == "Rowing"
    assert ActivityTypeFormatter.format("Run") == "Run"
    assert ActivityTypeFormatter.format("Sail") == "Sail"
    assert ActivityTypeFormatter.format("Skateboard") == "Skateboard"
    assert ActivityTypeFormatter.format("Snowboard") == "Snowboard"
    assert ActivityTypeFormatter.format("Snowshoe") == "Snowshoe"
    assert ActivityTypeFormatter.format("Soccer") == "Soccer"
    assert ActivityTypeFormatter.format("StairStepper") == "Stair Stepper"
    assert ActivityTypeFormatter.format("StandUpPaddling") == "SUP"
    assert ActivityTypeFormatter.format("Surfing") == "Surfing"
    assert ActivityTypeFormatter.format("Swim") == "Swim"
    assert ActivityTypeFormatter.format("Velomobile") == "Velomobile"
    assert ActivityTypeFormatter.format("VirtualRide") == "Ride"
    assert ActivityTypeFormatter.format("VirtualRun") == "Run"
    assert ActivityTypeFormatter.format("Walk") == "Walk"
    assert ActivityTypeFormatter.format("WeightTraining") == "Weight Training"
    assert ActivityTypeFormatter.format("Wheelchair") == "Wheelchair"
    assert ActivityTypeFormatter.format("Windsurf") == "Windsurf"
    assert ActivityTypeFormatter.format("Workout") == "Workout"
    assert ActivityTypeFormatter.format("Yoga") == "Yoga"
  end
end
