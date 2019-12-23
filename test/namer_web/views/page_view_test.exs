defmodule NamerWeb.PageViewTest do
  use NamerWeb.ConnCase, async: true

  alias NamerWeb.PageView

  test "title includes emoji" do
    assert PageView.title(%{}, %{}) =~ "Emojify your Strava Activities"
  end
end
