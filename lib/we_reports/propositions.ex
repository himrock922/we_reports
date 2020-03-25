defmodule WeReports.Propositions do
  @moduledoc """
  The Propositions context.
  """

  import Ecto.Query, warn: false
  alias WeReports.{Groups.Group, Propositions.Proposition, Repo}

  @doc """
  Returns the list of propositions.

  ## Examples

      iex> list_propositions()
      [%Proposition{}, ...]

  """
  def list_propositions(id), do: Repo.get!(Group, id) |> Repo.preload(:propositions)

  @doc """
  Gets a single proposition.

  Raises `Ecto.NoResultsError` if the Proposition does not exist.

  ## Examples

      iex> get_proposition!(123)
      %Proposition{}

      iex> get_proposition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_proposition!(id), do: Repo.get!(Proposition, id) |> Repo.preload(:group)

  @doc """
  Creates a proposition.

  ## Examples

      iex> create_proposition(%{field: value})
      {:ok, %Proposition{}}

      iex> create_proposition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_proposition(attrs \\ %{}) do
    %Proposition{}
    |> Proposition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a proposition.

  ## Examples

      iex> update_proposition(proposition, %{field: new_value})
      {:ok, %Proposition{}}

      iex> update_proposition(proposition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_proposition(%Proposition{} = proposition, attrs) do
    proposition
    |> Proposition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Proposition.

  ## Examples

      iex> delete_proposition(proposition)
      {:ok, %Proposition{}}

      iex> delete_proposition(proposition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_proposition(%Proposition{} = proposition) do
    Repo.delete(proposition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking proposition changes.

  ## Examples

      iex> change_proposition(proposition)
      %Ecto.Changeset{source: %Proposition{}}

  """
  def change_proposition(%Proposition{} = proposition) do
    Proposition.changeset(proposition, %{})
  end
end
