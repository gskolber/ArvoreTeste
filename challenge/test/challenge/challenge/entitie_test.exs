defmodule Challenge.Challenge.EntitieTest do
  use Challenge.DataCase
    alias Challenge.Organization.Entitie


    describe "entities changeset" do
      @valid_values_network %{name: "Network 1", entity_type: "network"}
      @valid_values_school %{name: "School 1", entity_type: "school", inep: 1231}
      @valid_values_class %{name: "Class 1", entity_type: "class", parent_id: 5}

      test "should return a valid for network creation" do
        changeset = Entitie.changeset(%Entitie{}, @valid_values_network)
        assert changeset.valid?
      end

      test "should return a valid for school creation" do
        changeset = Entitie.changeset(%Entitie{}, @valid_values_school)
        assert changeset.valid?
      end

      test "should return a valid for class creation" do
        changeset = Entitie.changeset(%Entitie{}, @valid_values_class)
        assert changeset.valid?
      end

      test "should return a invalid network" do
        changeset = Entitie.changeset(%Entitie{}, Map.delete(@valid_values_network, :name))
        refute changeset.valid?
      end

      test "should return a invalid school" do
        changeset = Entitie.changeset(%Entitie{}, Map.delete(@valid_values_school, :inep))
        refute changeset.valid?
      end

      test "should return a invalid class" do
        changeset = Entitie.changeset(%Entitie{}, Map.delete(@valid_values_school, :parent_id))
      end

    end

end
