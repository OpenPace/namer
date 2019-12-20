defmodule Namer.NameGeneratorTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.NameGenerator

  describe "generate_name/2" do
    test "builds the correct name" do
      user = build_user()
      activity = build_activity()
      assert NameGenerator.generate_name(user, activity) == "🏃 4.7 mi Run"
    end
  end

  defp build_user do
    %{user_prefs: %{emoji: true, imperial: true}}
  end

  defp build_activity do
    %Strava.DetailedActivity{
      distance: 1500 * 5,
      moving_time: 7 * 5 * 60,
      type: "Run",
      description: ""
    }
  end
end
