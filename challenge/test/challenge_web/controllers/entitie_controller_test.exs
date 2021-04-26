defmodule ChallengeWeb.EntitieControllerTest do
  use ChallengeWeb.ConnCase

  alias Challenge.Organization
  alias Challenge.Organization.Entitie

  @create_attrs %{
    entity_type: "some entity_type",
    inep: 42,
    name: "some name",
    parent_id: 42
  }
  @update_attrs %{
    entity_type: "some updated entity_type",
    inep: 43,
    name: "some updated name",
    parent_id: 43
  }
  @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

  def fixture(:entitie) do
    {:ok, entitie} = Organization.create_entitie(@create_attrs)
    entitie
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entities", %{conn: conn} do
      conn = get(conn, Routes.entitie_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entitie" do
    test "renders entitie when data is valid", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.entitie_path(conn, :show, id))

      assert %{
               "id" => id,
               "entity_type" => "some entity_type",
               "inep" => 42,
               "name" => "some name",
               "parent_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update entitie" do
    setup [:create_entitie]

    test "renders entitie when data is valid", %{conn: conn, entitie: %Entitie{id: id} = entitie} do
      conn = put(conn, Routes.entitie_path(conn, :update, entitie), entitie: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.entitie_path(conn, :show, id))

      assert %{
               "id" => id,
               "entity_type" => "some updated entity_type",
               "inep" => 43,
               "name" => "some updated name",
               "parent_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, entitie: entitie} do
      conn = put(conn, Routes.entitie_path(conn, :update, entitie), entitie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete entitie" do
    setup [:create_entitie]

    test "deletes chosen entitie", %{conn: conn, entitie: entitie} do
      conn = delete(conn, Routes.entitie_path(conn, :delete, entitie))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.entitie_path(conn, :show, entitie))
      end
    end
  end

  defp create_entitie(_) do
    entitie = fixture(:entitie)
    %{entitie: entitie}
  end
end
