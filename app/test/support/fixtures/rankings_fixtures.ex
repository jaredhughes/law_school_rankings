defmodule App.RankingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Rankings` context.
  """

  @doc """
  Generate a ranking.
  """
  def ranking_fixture(attrs \\ %{}) do
    {:ok, ranking} =
      attrs
      |> Enum.into(%{

      })
      |> App.Rankings.create_ranking()

    ranking
  end
end
