defmodule App.Schema.GpaScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gpa_scores" do
    field :percentile_25, :float
    field :percentile_50, :float
    field :percentile_75, :float
    field :school, :id
    field :first_year_class, :id

    timestamps()
  end

  @doc false
  def changeset(gpa_scores, attrs) do
    gpa_scores
    |> cast(attrs, [:percentile_25, :percentile_50, :percentile_75])
    |> validate_required([:percentile_25, :percentile_50, :percentile_75])
  end
end
