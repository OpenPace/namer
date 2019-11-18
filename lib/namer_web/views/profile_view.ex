defmodule NamerWeb.ProfileView do
  use NamerWeb, :view

  def title(_page, _assigns) do
    gettext("Profile")
  end
end
