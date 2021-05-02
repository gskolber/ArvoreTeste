defmodule Challenge.Organization.Entitie do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_entities ["school", "network", "class"]
  @required_fields [:name, :entity_type]
  @all_fields [:inep, :parent_id | @required_fields]

  schema "entities" do
    field :entity_type, :string
    field :inep, :integer
    field :name, :string
    field :parent_id, :integer
    field :subtree, {:array, :integer}, virtual: true

    timestamps()
  end

  @doc false
  def changeset(entitie, attrs) do
    entitie
    |> cast(attrs, [:subtree | @all_fields])
    |> validate_inclusion(:entity_type, @valid_entities)
    |> entitie_validations
  end

  defp entitie_validations(changeset) when changeset.changes.entity_type == "school" do
    changeset
    |> validate_required([:inep | @required_fields])
    |> unique_constraint(:inep)
  end

  defp entitie_validations(changeset) when changeset.changes.entity_type == "network" do
    changeset
    |> validate_required(@required_fields)
  end

  defp entitie_validations(changeset) when changeset.changes.entity_type == "class" do
    changeset
    |> validate_required([:parent_id | @required_fields])
  end

  defp entitie_validations(changeset) do
    changeset
    |> validate_required([:parent_id, :inep | @required_fields])
  end
end
