defmodule NamerWeb.PageView do
  use NamerWeb, :view

  def title(_page, _assigns) do
    gettext("Emojify your Strava Activities")
  end

  def company_name, do: "OpenPace"
  def copyright_year, do: Date.utc_today.year
end
