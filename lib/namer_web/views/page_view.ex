defmodule NamerWeb.PageView do
  use NamerWeb, :view

  def title(_page, _assigns) do
    gettext("Emojify your Strava Activities")
  end
end
