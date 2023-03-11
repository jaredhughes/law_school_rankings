defmodule App.Schema.GreScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gre_scores" do
    field :quantitative_percentile_25, :integer
    field :quantitative_percentile_50, :integer
    field :quantitative_percentile_75, :integer
    field :verbal_percentile_25, :integer
    field :verbal_percentile_50, :integer
    field :verbal_percentile_75, :integer
    field :written_percentile_25, :float
    field :written_percentile_50, :float
    field :written_percentile_75, :float
    belongs_to :school, App.Schema.School
    belongs_to :first_year_class, App.Schema.FirstYearClass

    timestamps()
  end

  @required_fields [
    :verbal_percentile_25,
    :verbal_percentile_50,
    :verbal_percentile_75,
    :quantitative_percentile_25,
    :quantitative_percentile_50,
    :quantitative_percentile_75,
    :written_percentile_25,
    :written_percentile_50,
    :written_percentile_75,
    :school_id,
    :first_year_class_id
  ]

  @doc false
  def changeset(gre_scores, attrs) do
    gre_scores
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
