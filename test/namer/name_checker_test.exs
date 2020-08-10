defmodule Namer.NameCheckerTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.NameChecker
  alias Strava.DetailedActivity

  describe "strava_default?/1" do
    test "returns true for Morning Run" do
      assert check_name("Morning Run")
    end

    test "returns true for Lunch Ride" do
      assert check_name("Lunch Ride")
    end

    test "returns true for Afternoon Swim" do
      assert check_name("Afternoon Swim")
    end

    test "returns true for Evening Hike" do
      assert check_name("Evening Hike")
    end

    test "returns true for Night Walk" do
      assert check_name("Night Walk")
    end

    test "returns true for Morning Activity" do
      assert check_name("Morning Activity")
    end

    test "returns false for custom activity time" do
      refute check_name("Dinner Run")
    end

    test "returns false for three word name" do
      refute check_name("Fun Morning Run")
    end

    test "returns false for custom activity name" do
      refute check_name("Morning Yoga")
    end
  end

  defp check_name(name) do
    activity = %DetailedActivity{name: name}
    NameChecker.strava_default?(activity)
  end
end
