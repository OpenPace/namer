defmodule Namer.DistanceFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.DistanceFormatter

  describe "#format/2" do
    test "with swim and imperial" do
      assert format(%{type: "Swim", distance: 500}, imperial: true) == "547 yd"
    end

    test "with swim and metric" do
      assert format(%{type: "Swim", distance: 500}, imperial: false) == "500 m"
    end

    test "with zero meter distance" do
      assert format(%{distance: 0}, imperial: false) == nil
    end

    test "with a nil distance" do
      assert format(%{distance: nil}, imperial: false) == nil
    end

    test "with imperial: true returns miles" do
      assert format(%{distance: 10_000}, imperial: true) == "6.2 mi"
    end

    test "with imperial: false returns km" do
      assert format(%{distance: 10_000}, imperial: false) == "10.0 km"
    end
  end

  defp format(activity, opts) do
    DistanceFormatter.format(activity, opts)
  end
end
