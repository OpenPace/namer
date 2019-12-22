defmodule Namer.RelativeTimeFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.RelativeTimeFormatter

  describe "format/1" do
    test "without a start_date_local" do
      assert RelativeTimeFormatter.format(%{}) == nil
    end

    test "with a nil start_date_local" do
      assert RelativeTimeFormatter.format(%{start_date_local: nil}) == nil
    end

    test "with morning timestamp" do
      t = Timex.to_datetime({{2015, 6, 24}, {5, 50, 34}}) # 5:50 am
      assert RelativeTimeFormatter.format(%{start_date_local: t}) == "Morning"
    end

    test "with afternoon timestamp" do
      t = Timex.to_datetime({{2015, 6, 24}, {12, 50, 34}}) # 12:50 pm
      assert RelativeTimeFormatter.format(%{start_date_local: t}) == "Afternoon"
    end

    test "with evening timestamp" do
      t = Timex.to_datetime({{2015, 6, 24}, {17, 50, 34}}) # 5:50 pm
      assert RelativeTimeFormatter.format(%{start_date_local: t}) == "Evening"
    end

    test "with night timestamp" do
      t = Timex.to_datetime({{2015, 6, 24}, {22, 50, 34}}) # 10:50 pm
      assert RelativeTimeFormatter.format(%{start_date_local: t}) == "Night"
    end
  end
end
