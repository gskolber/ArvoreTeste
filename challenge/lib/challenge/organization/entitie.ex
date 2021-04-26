defmodule Challenge.Organization.Entitie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :entity_type, :string
    field :inep, :integer
    field :name, :string
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(entitie, attrs) do
    entitie
    |> cast(attrs, [:name, :entity_type, :inep, :parent_id])
    |> validate_required([:name, :entity_type, :inep, :parent_id])
  end
end
