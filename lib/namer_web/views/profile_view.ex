defmodule NamerWeb.ProfileView do
  use NamerWeb, :view

  def title(_page, _assigns) do
    gettext("Profile")
  end

  def gender_opts do
    GenderEnum.__enum_map__()
    |> Enum.map(fn ({k, _}) -> {format_option(k), k} end)
  end

  defp format_option(opt) do
    opt
    |> Atom.to_string()
    |> String.replace("_", " ")
    |> String.capitalize()
  end
end
