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
    |> Enum.sort_by(fn {key, _value} -> key end, :desc)
  end
end
