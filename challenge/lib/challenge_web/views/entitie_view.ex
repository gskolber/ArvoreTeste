defmodule ChallengeWeb.EntitieView do
  use ChallengeWeb, :view
  alias ChallengeWeb.EntitieView

  def render("index.json", %{entities: entities}) do
    %{data: render_many(entities, EntitieView, "entitie.json")}
  end

  def render("post.json", %{entitie: entitie}) do
    %{id: entitie.id,}
    %{data: render_one(entitie, EntitieView, "entitie.json")}
  end

  def render("show.json", %{entitie: entitie, subtree: subtree}) do
    %{id: entitie.id,
      name: entitie.name,
      entity_type: entitie.entity_type,
      inep: entitie.inep,
      parent_id: entitie.parent_id,
      subtree: subtree}
  end

  def render("entitie.json", %{entitie: entitie}) do
    %{id: entitie.id,
      name: entitie.name,
      entity_type: entitie.entity_type,
      inep: entitie.inep,
      parent_id: entitie.parent_id}
  end
end
