defmodule Challenge.Repo.Migrations.ChangeToUnique do
  use Ecto.Migration

  def change do
    create unique_index(:entities, [:inep])
  end
end
