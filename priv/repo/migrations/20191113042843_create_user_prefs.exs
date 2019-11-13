defmodule Namer.Repo.Migrations.CreateUserPrefs do
  use Ecto.Migration

  def change do
    create table(:user_prefs) do
      add :emoji, :boolean, default: true, null: false
      add :branding, :boolean, default: true, null: false

      timestamps()
    end

  end
end
