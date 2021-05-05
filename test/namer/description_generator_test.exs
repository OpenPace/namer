defmodule Namer.DescriptionGeneratorTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.DescriptionGenerator
  alias Strava.DetailedActivity

  describe "generate_description/2" do
    test "with branding and no description" do
      user = build_user()
      activity = build_activity()
      assert DescriptionGenerator.generate_description(user, activity) == "Renamed with openpace.co/namer"
    end

    test "with branding and an existing description" do
      user = build_user()
      activity = build_activity("Test")
      description = DescriptionGenerator.generate_description(user, activity)
      assert description == "Test - Renamed with openpace.co/namer"
    end

    test "without branding and no description" do
      activity = build_activity()
      description = DescriptionGenerator.generate_description(%{}, activity)
      assert description == nil
    end

    test "without branding and an exisiting description" do
      activity = build_activity("Test")
      description = DescriptionGenerator.generate_description(%{}, activity)
      assert description == "Test"
    end
  end

  defp build_user, do: %{premium: false, user_prefs: %{branding: true}}
  defp build_activity(description \\ nil) do
    %DetailedActivity{
      distance: 1500 * 5,
      moving_time: 7 * 5 * 60,
      type: "Run",
      description: description
    }
  end
end
