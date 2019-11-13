defmodule Namer.Repo.Migrations.AddUniqueIndexUidToUsers do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:strava_uid], name: "users_strava_id_uniq_index")
  end
end
