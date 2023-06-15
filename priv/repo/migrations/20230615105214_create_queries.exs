defmodule TestMonaco.Repo.Migrations.CreateQueries do
  use Ecto.Migration

  def change do
    create table(:queries) do
      add :query, :string

      timestamps()
    end
  end
end
