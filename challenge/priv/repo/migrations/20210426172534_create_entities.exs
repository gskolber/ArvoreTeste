defmodule Challenge.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :entity_type, :string
      add :inep, :integer
      add :parent_id, :integer

      timestamps()
    end

  end
end
