defmodule Namer.Accounts.User do
  @moduledoc """
  This module is the schema for the user and strava authentication.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Namer.Accounts.UserPrefs

  @required_fields ~w(
    name
    strava_uid
    access_token
    refresh_token
  )a
  @optional_fields ~w(
    email
    avatar
  )a

  schema "users" do
    field :access_token, :string
    field :name, :string
    field :refresh_token, :string
    field :strava_uid, :string

    field :avatar, :string
    field :email, :string

    has_one :user_prefs, UserPrefs

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_required(@required_fields)
  end
end
