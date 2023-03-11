defmodule App.Rankings do
  @moduledoc """
  The Rankings context.
  """

  import Ecto.Query, warn: false
  alias App.Repo
  alias App.Schema.Ranking

  @doc """
  Returns the list of rankings.

  ## Examples

      iex> list_rankings()
      [%Ranking{}, ...]

  """
  def list_rankings do
    raise "TODO"
  end

  @doc """
  Gets a single ranking.

  Raises if the Ranking does not exist.

  ## Examples

      iex> get_ranking!(123)
      %Ranking{}

  """
  def get_ranking!(id), do: raise("TODO")

  @doc """
  Creates a ranking.

  ## Examples

      iex> create_ranking(%{field: value})
      {:ok, %Ranking{}}

      iex> create_ranking(%{field: bad_value})
      {:error, ...}

  """
  def create_ranking(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a ranking.

  ## Examples

      iex> update_ranking(ranking, %{field: new_value})
      {:ok, %Ranking{}}

      iex> update_ranking(ranking, %{field: bad_value})
      {:error, ...}

  """
  def update_ranking(%Ranking{} = ranking, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Ranking.

  ## Examples

      iex> delete_ranking(ranking)
      {:ok, %Ranking{}}

      iex> delete_ranking(ranking)
      {:error, ...}

  """
  def delete_ranking(%Ranking{} = ranking) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking ranking changes.

  ## Examples

      iex> change_ranking(ranking)
      %Todo{...}

  """
  def change_ranking(%Ranking{} = ranking, _attrs \\ %{}) do
    raise "TODO"
  end
end
