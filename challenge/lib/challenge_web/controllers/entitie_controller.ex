defmodule ChallengeWeb.EntitieController do
  use ChallengeWeb, :controller
  use PhoenixSwagger

  alias Challenge.Organization
  alias Challenge.Organization.Entitie
  alias PhoenixSwagger.Schema

  action_fallback ChallengeWeb.FallbackController

  swagger_path :index do
    get("/api/entities")
    tag("entitie")
    produces("application/json")
    description("lista todas as entidades")
    response(200, "sucesso")
  end

  swagger_path :create do
    post("/api/entities")
    produces("application/json")
    tag("entitie")
    description("Cria uma entidade")

    parameters do
      entity(:body, Schema.ref(:Entitie), "Dados da entidade", required: true)
    end

    response(200, "sucesso", Schema.ref(:Entitie))
  end

  swagger_path :show do
    get("/api/entities/{id}")
    produces("application/json")
    tag("entitie")
    description("Lista a entidade por id")

    parameters do
      id(:path, :string, "id da entidade", required: true)
    end

    response(200, "sucesso", Schema.ref(:Entitie))
  end

  swagger_path :update do
    patch("/api/entities")
    produces("application/json")
    tag("entitie")
    description("Atualiza uma entidade")

    parameters do
      entity(:body, Schema.ref(:Entitie), "Dados da entidade", required: true)
    end

    response(200, "sucesso", Schema.ref(:Entitie))
  end

  def index(conn, _params) do
    entities = Organization.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entitie" => entitie_params}) do
    with {:ok, %Entitie{} = entitie} <- Organization.create_entitie(entitie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.entitie_path(conn, :show, entitie))
      |> render("post.json", entitie: entitie)
    end
  end

  def show(conn, %{"id" => id}) do
    entitie = Organization.get_entitie!(id)
    subtree = Organization.get_entities_by_id(id)
    render(conn, "show.json", entitie: entitie, subtree: subtree)
  end

  def update(conn, %{"id" => id, "entitie" => entitie_params}) do
    entitie = Organization.get_entitie!(id)

    with {:ok, %Entitie{} = entitie} <- Organization.update_entitie(entitie, entitie_params) do
      render(conn, "post.json", entitie: entitie)
    end
  end

  def delete(conn, %{"id" => id}) do
    entitie = Organization.get_entitie!(id)

    with {:ok, %Entitie{}} <- Organization.delete_entitie(entitie) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Entitie:
        swagger_schema do
          title("entitie")
          description("Entidade comum do sistema")

          properties do
            name(:string, "Nome da entidade", required: true)
            entity_type(:string, "'school','network','class'", required: true)
            inep(:integer, "Identificador da school")
            parent_id(:integer, "Id da classe pai")
          end

          example(%{
            name: "La Salle - São Leopoldo",
            entity_type: "school",
            inep: "253614",
            parent_id: "1"
          })
        end
    }
  end
end
