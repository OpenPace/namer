defmodule Namer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access_token, :string
    field :avatar, :string
    field :name, :string
    field :refresh_token, :string
    field :strava_uid, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :avatar, :strava_uid, :access_token, :refresh_token])
    |> validate_required([:name, :avatar, :strava_uid, :access_token, :refresh_token])
  end
end
