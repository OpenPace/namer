defmodule Namer.Accounts.UserPrefs do
  @moduledoc """
  This module is the schema for the user preferences.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Namer.Accounts.User

  @required_fields ~w()a
  @optional_fields ~w(
    branding
    emoji
    gender
    imperial
  )a

  schema "user_prefs" do
    field :emoji, :boolean
    field :branding, :boolean
    field :imperial, :boolean
    field :gender, GenderEnum

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(user_prefs, attrs) do
    user_prefs
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
