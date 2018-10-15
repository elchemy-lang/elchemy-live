defmodule Ellie.Repo.Migrations.AddElixirCode do
  use Ecto.Migration

  def up do
    alter table(:revisions, primary_key: false) do
      add :elixir_code, :text, null: false
    end
  end

  def down do
    alter table(:revisions, primary_key: false) do
      remove :elixir_code
    end
  end
end
