defmodule Namer.Repo.Migrations.AddGenderToUserPrefs do
  use Ecto.Migration

  def change do
    alter table(:user_prefs) do
      add :gender, :integer, default: 0, null: false
    end
  end
end
