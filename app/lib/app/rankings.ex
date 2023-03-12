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
  def list_rankings() do
    Ranking
    |> preload([:school, :first_year_class])
    |> Repo.all()
  end
end
