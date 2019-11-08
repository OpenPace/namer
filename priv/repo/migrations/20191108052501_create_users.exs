defmodule Namer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :avatar, :string
      add :strava_uid, :string
      add :access_token, :string
      add :refresh_token, :string

      timestamps()
    end

    create index(:users, [:strava_uid])
  end
end
