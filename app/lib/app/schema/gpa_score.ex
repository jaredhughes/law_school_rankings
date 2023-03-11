defmodule App.Schema.GpaScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gpa_scores" do
    field(:percentile_25, :float)
    field(:percentile_50, :float)
    field(:percentile_75, :float)
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
  def changeset(gpa_scores, attrs) do
    gpa_scores
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
