defmodule YouboxApi.Presences do
  @moduledoc """
  The Presences context.
  """

  import Ecto.Query, warn: false
  alias YouboxApi.Repo

  alias YouboxApi.Presences.Presence

  @doc """
  Returns the list of presences.

  ## Examples

      iex> list_presences()
      [%Presence{}, ...]

  """
  def list_presences do
    Repo.all(Presence)
  end

  @doc """
  Gets a single presence.

  Raises `Ecto.NoResultsError` if the Presence does not exist.

  ## Examples

      iex> get_presence!(123)
      %Presence{}

      iex> get_presence!(456)
      ** (Ecto.NoResultsError)

  """
  def get_presence!(id), do: Repo.get!(Presence, id)

  @doc """
  Creates a presence.

  ## Examples

      iex> create_presence(%{field: value})
      {:ok, %Presence{}}

      iex> create_presence(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_presence(attrs \\ %{}) do
    %Presence{}
    |> Presence.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a presence.

  ## Examples

      iex> update_presence(presence, %{field: new_value})
      {:ok, %Presence{}}

      iex> update_presence(presence, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_presence(%Presence{} = presence, attrs) do
    presence
    |> Presence.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a presence.

  ## Examples

      iex> delete_presence(presence)
      {:ok, %Presence{}}

      iex> delete_presence(presence)
      {:error, %Ecto.Changeset{}}

  """
  def delete_presence(%Presence{} = presence) do
    Repo.delete(presence)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking presence changes.

  ## Examples

      iex> change_presence(presence)
      %Ecto.Changeset{data: %Presence{}}

  """
  def change_presence(%Presence{} = presence, attrs \\ %{}) do
    Presence.changeset(presence, attrs)
  end
end
