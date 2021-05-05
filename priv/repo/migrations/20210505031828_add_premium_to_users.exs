defmodule Namer.Repo.Migrations.AddPremiumToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :premium, :boolean, default: false, null: false
    end
  end
end
