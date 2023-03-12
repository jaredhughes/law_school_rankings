defmodule App.Schema.FirstYearClass do
  use Ecto.Schema
  import Ecto.Changeset

  schema "first_year_classes" do
    field(:year, :integer)
    has_many(:rankings, App.Schema.Ranking)
    has_many(:gpa_scores, App.Schema.GpaScore)
    has_many(:gre_scores, App.Schema.GreScore)
    has_many(:lsat_scores, App.Schema.LsatScore)

    timestamps()
  end

  @doc false
  def changeset(first_year_class, attrs) do
    first_year_class
    |> cast(attrs, [:year])
    |> validate_required([:year])
  end
end
