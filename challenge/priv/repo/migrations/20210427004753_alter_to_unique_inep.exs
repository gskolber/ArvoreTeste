defmodule Challenge.Repo.Migrations.AlterToUniqueInep do
  use Ecto.Migration

  def change do
    alter table(:entities) do
      modify :inep, :integer, unique: true
    end
  end
end
