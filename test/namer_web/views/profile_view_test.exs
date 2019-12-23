defmodule NamerWeb.ProfileViewTest do
  use NamerWeb.ConnCase, async: true

  alias NamerWeb.ProfileView

  test "title includes emoji" do
    assert ProfileView.title(%{}, %{}) =~ "Profile"
  end
end
