defmodule Challenge.Organization do
  @moduledoc """
  The Organization context.
  """

  import Ecto.Query, warn: false
  alias Challenge.Repo

  alias Challenge.Organization.Entitie

  @doc """
  Returns the list of entities.

  ## Examples

      iex> list_entities()
      [%Entitie{}, ...]

  """
  def list_entities do
    Repo.all(Entitie)
  end

  @doc """
  Gets a single entitie.

  Raises `Ecto.NoResultsError` if the Entitie does not exist.

  ## Examples

      iex> get_entitie!(123)
      %Entitie{}

      iex> get_entitie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entitie!(id), do: Repo.get!(Entitie, id)

  @doc """
  Creates a entitie.

  ## Examples

      iex> create_entitie(%{field: value})
      {:ok, %Entitie{}}

      iex> create_entitie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entitie(attrs \\ %{}) do
    %Entitie{}
    |> Entitie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entitie.

  ## Examples

      iex> update_entitie(entitie, %{field: new_value})
      {:ok, %Entitie{}}

      iex> update_entitie(entitie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entitie(%Entitie{} = entitie, attrs) do
    entitie
    |> Entitie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entitie.

  ## Examples

      iex> delete_entitie(entitie)
      {:ok, %Entitie{}}

      iex> delete_entitie(entitie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entitie(%Entitie{} = entitie) do
    Repo.delete(entitie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entitie changes.

  ## Examples

      iex> change_entitie(entitie)
      %Ecto.Changeset{data: %Entitie{}}

  """
  def change_entitie(%Entitie{} = entitie, attrs \\ %{}) do
    Entitie.changeset(entitie, attrs)
  end
end
