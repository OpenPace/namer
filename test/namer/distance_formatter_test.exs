defmodule Namer.DistanceFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.DistanceFormatter

  test "mile_in_meters" do
    assert DistanceFormatter.mile_in_meters == 1609
  end

  describe "#format/2" do
    test "with imperial: true returns miles" do
      assert DistanceFormatter.format(10_000, imperial: true) == "6.2 mi"
    end

    test "with imperial: false returns km" do
      assert DistanceFormatter.format(10_000, imperial: false) == "10.0 km"
    end
  end

  test "#format/1 returns km" do
    assert DistanceFormatter.format(10_000) == "10.0 km"
  end
end
