defmodule ChallengeWeb.EntitieController do
  use ChallengeWeb, :controller

  alias Challenge.Organization
  alias Challenge.Organization.Entitie

  action_fallback ChallengeWeb.FallbackController

  def index(conn, _params) do
    entities = Organization.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entitie" => entitie_params}) do
    with {:ok, %Entitie{} = entitie} <- Organization.create_entitie(entitie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.entitie_path(conn, :show, entitie))
      |> render("show.json", entitie: entitie)
    end
  end

  def show(conn, %{"id" => id}) do
    entitie = Organization.get_entitie!(id)
    render(conn, "show.json", entitie: entitie)
  end

  def update(conn, %{"id" => id, "entitie" => entitie_params}) do
    entitie = Organization.get_entitie!(id)

    with {:ok, %Entitie{} = entitie} <- Organization.update_entitie(entitie, entitie_params) do
      render(conn, "show.json", entitie: entitie)
    end
  end

  def delete(conn, %{"id" => id}) do
    entitie = Organization.get_entitie!(id)

    with {:ok, %Entitie{}} <- Organization.delete_entitie(entitie) do
      send_resp(conn, :no_content, "")
    end
  end
end
