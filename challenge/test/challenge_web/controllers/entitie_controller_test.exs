defmodule ChallengeWeb.EntitieControllerTest do
  use ChallengeWeb.ConnCase

  alias Challenge.Organization
  alias Challenge.Organization.Entitie

  @create_attrs_network %{
    entity_type: "network",
    name: "some name network"
  }

  @create_attrs_school %{
    entity_type: "school",
    inep: 42,
    name: "some name school"
  }

  @create_attrs_class %{
    entity_type: "class",
    parent_id: 1,
    name: "some name class"
  }

  @update_attrs %{
    entity_type: "class",
    parent_id: 1,
    name: "other class"
  }


  @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

  def fixture(:entitie) do
    {:ok, entitie} = Organization.create_entitie(@create_attrs_network)
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
    test "returns a valid entity school", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @create_attrs_school)
      assert %{"data" => data} = json_response(conn, 201)


      conn = get(conn, Routes.entitie_path(conn, :show, data["id"]))

      assert %{
        "name" => "some name school",
        "entity_type" => "school",
        "id" => id,
        "inep" =>42,
        "parent_id" => nil,
        "subtree" => []
      } = json_response(conn, 200)


    end

    test "returns a valid entity network", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @create_attrs_network)
      assert %{"data" => data} = json_response(conn, 201)


      conn = get(conn, Routes.entitie_path(conn, :show, data["id"]))

      assert %{
        "name" => "some name network",
        "entity_type" => "network",
        "id" => id,
      } = json_response(conn, 200)

    end

    test "returns a valid entity class", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @create_attrs_class)
      assert %{"data" => data} = json_response(conn, 201)


      conn = get(conn, Routes.entitie_path(conn, :show, data["id"]))

      assert %{
        "name" => "some name class",
        "entity_type" => "class",
        "id" => id,
        "parent_id" => 1
      } = json_response(conn, 200)

    end


    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when class dont have a parent_id", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: Map.delete(@create_attrs_class, :parent_id))
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when school dont have a inep code", %{conn: conn} do
      conn = post(conn, Routes.entitie_path(conn, :create), entitie: Map.delete(@create_attrs_school, :inep))
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
               "entity_type" => "class",
               "name" => "other class",
               "parent_id" => 1
             } = json_response(conn, 200)
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
