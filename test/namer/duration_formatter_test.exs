defmodule Namer.DurationFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.DurationFormatter

  describe "#format/1" do
    test "over 1 hr with double digit minutes" do
      assert format(74) == "1h 14m"
    end

    test "over 1 hr with single digit minutes" do
      assert format(64) == "1h 04m"
    end

    test "under 1 hr" do
      assert format(54) == "54min"
    end

    test "under 10 minutes" do
      assert format(9) == "9min"
    end
  end

  defp format(min) do
    t = min * 60
    DurationFormatter.format(t)
  end
end
