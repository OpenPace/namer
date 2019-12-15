defmodule Namer.Repo.Migrations.AddLocaleToUserPrefs do
  use Ecto.Migration

  def change do
    alter table(:user_prefs) do
      add :locale, :string
    end
  end
end
