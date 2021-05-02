defmodule Challenge.OrganizationTest do
  use Challenge.DataCase

  alias Challenge.Organization

  describe "entities" do
    alias Challenge.Organization.Entitie

    @valid_attrs %{entity_type: "school", inep: 42, name: "La Salle - São Leopoldo"}
    @update_attrs %{entity_type: "network", name: "teste"}
    @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

    def entitie_fixture(attrs \\ %{}) do
      {:ok, entitie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organization.create_entitie()

      entitie
    end

    test "list_entities/0 returns all entities" do
      entitie = entitie_fixture()
      assert Organization.list_entities() == [entitie]
    end

    test "get_entitie!/1 returns the entitie with given id" do
      entitie = entitie_fixture()
      assert Organization.get_entitie!(entitie.id) == entitie
    end

    test "create_entitie/1 with valid data creates a entitie" do
      assert {:ok, %Entitie{} = entitie} = Organization.create_entitie(@valid_attrs)
      assert entitie.entity_type == "school"
      assert entitie.inep == 42
      assert entitie.name == "La Salle - São Leopoldo"
    end

    test "create_entitie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organization.create_entitie(@invalid_attrs)
    end

    test "update_entitie/2 with valid data updates the entitie" do
      entitie = entitie_fixture()
      assert {:ok, %Entitie{} = entitie} = Organization.update_entitie(entitie, @update_attrs)
      assert entitie.entity_type == "network"
      assert entitie.name == "teste"
    end

    test "update_entitie/2 with invalid data returns error changeset" do
      entitie = entitie_fixture()
      assert {:error, %Ecto.Changeset{}} = Organization.update_entitie(entitie, @invalid_attrs)
      assert entitie == Organization.get_entitie!(entitie.id)
    end

    test "delete_entitie/1 deletes the entitie" do
      entitie = entitie_fixture()
      assert {:ok, %Entitie{}} = Organization.delete_entitie(entitie)
      assert_raise Ecto.NoResultsError, fn -> Organization.get_entitie!(entitie.id) end
    end

    test "change_entitie/1 returns a entitie changeset" do
      entitie = entitie_fixture()
      assert %Ecto.Changeset{} = Organization.change_entitie(entitie)
    end
  end
end
