defmodule App.Rankings do
  @moduledoc """
  The Rankings context.
  """

  import Ecto.Query, warn: false
  alias App.Repo
  alias App.Schema.{School, LsatScore, GreScore, GpaScore}

  @spec list_schools :: [School.t()]
  def list_schools() do
    School
    |> order_by([s], asc: s.name)
    |> Repo.all()
    |> Enum.map(&{&1.name, &1.id})
  end

  @spec get_school(integer() | charlist()) :: School.t()
  def get_school(school_id) do
    Repo.get(School, school_id)
  end

  @spec get_scores(integer() | charlist()) :: [Map.t()]
  def get_scores(school_id) do
    lsat_scores =
      LsatScore
      |> where([lsat], lsat.school_id == ^school_id)
      |> preload(:first_year_class)
      |> Repo.all()

    gre_scores =
      GreScore
      |> where([gre], gre.school_id == ^school_id)
      |> preload(:first_year_class)
      |> Repo.all()

    gpa_scores =
      GpaScore
      |> where([gpa], gpa.school_id == ^school_id)
      |> preload(:first_year_class)
      |> Repo.all()

    (lsat_scores ++ gre_scores ++ gpa_scores)
    |> Enum.group_by(& &1.first_year_class.year)
    |> Enum.sort_by(fn {key, _} -> key end, :desc)
    |> Enum.map(fn {y, scores} ->
      {y, Enum.reduce(scores, %{}, &make_score_key/2)}
    end)
  end

  @spec rankings_by_year(integer() | charlist()) :: Map.t()
  def rankings_by_year(school_id) do
    School
    |> join(:inner, [s], r in assoc(s, :rankings))
    |> join(:inner, [s, r], fyc in assoc(r, :first_year_class))
    |> where([s, _], s.id == ^school_id)
    |> select([s, r, fyc], %{year: fyc.year, rank: r.rank})
    |> Repo.all()
    |> Enum.reduce(%{}, fn v, acc ->
      Map.put(acc, v.year, v.rank)
    end)
  end

  @spec get_lsat_fact(integer() | charlist()) :: charlist()
  def get_lsat_fact(school_id) do
    most_recent =
      LsatScore
      |> join(:inner, [lsat], fyc in assoc(lsat, :first_year_class))
      |> join(:inner, [lsat, _], s in assoc(lsat, :school))
      |> where([lsat, _, _], lsat.school_id == ^school_id)
      |> order_by([_, fyc, _], desc: fyc.year)
      |> limit(1)
      |> select([lsat, fyc, s], %{
        year: fyc.year,
        score: lsat.percentile_50,
        school: s.name
      })
      |> Repo.one()

    "In #{most_recent.year}, #{most_recent.school} had a 50th percentile LSAT score of #{most_recent.score}."
  end

  defp make_score_key(%LsatScore{} = exam, scores) do
    Map.put(scores, :lsat, exam)
  end

  defp make_score_key(%GpaScore{} = exam, scores) do
    Map.put(scores, :gpa, exam)
  end

  defp make_score_key(%GreScore{} = exam, scores) do
    Map.put(scores, :gre, exam)
  end
end
