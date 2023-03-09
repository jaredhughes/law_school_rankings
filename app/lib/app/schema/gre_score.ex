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
    field :school, :id
    field :first_year_class, :id

    timestamps()
  end

  @doc false
  def changeset(gre_scores, attrs) do
    gre_scores
    |> cast(attrs, [:verbal_percentile_25, :verbal_percentile_50, :verbal_percentile_75, :quantitative_percentile_25, :quantitative_percentile_50, :quantitative_percentile_75, :written_percentile_25, :written_percentile_50, :written_percentile_75])
    |> validate_required([:verbal_percentile_25, :verbal_percentile_50, :verbal_percentile_75, :quantitative_percentile_25, :quantitative_percentile_50, :quantitative_percentile_75, :written_percentile_25, :written_percentile_50, :written_percentile_75])
  end
end
