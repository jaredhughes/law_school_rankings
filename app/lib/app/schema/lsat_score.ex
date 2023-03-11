defmodule App.Schema.LsatScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lsat_scores" do
    field(:percentile_25, :integer)
    field(:percentile_50, :integer)
    field(:percentile_75, :integer)
    belongs_to(:school, App.Schema.School)
    belongs_to(:first_year_class, App.Schema.FirstYearClass)

    timestamps()
  end

  @required_fields [
    :percentile_25,
    :percentile_50,
    :percentile_75,
    :school_id,
    :first_year_class_id
  ]

  @doc false
  def changeset(lsat_scores, attrs) do
    lsat_scores
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
