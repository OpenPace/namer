defmodule Namer.Repo.Migrations.CreateUserPrefs do
  use Ecto.Migration

  def change do
    create table(:user_prefs) do
      add :emoji, :boolean, default: true, null: false
      add :branding, :boolean, default: true, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
