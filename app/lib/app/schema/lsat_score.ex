defmodule App.Schema.LsatScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lsat_scores" do
    field :percentile_25, :integer
    field :percentile_50, :integer
    field :percentile_75, :integer
    field :school, :id
    field :first_year_class, :id

    timestamps()
  end

  @doc false
  def changeset(lsat_scores, attrs) do
    lsat_scores
    |> cast(attrs, [:percentile_25, :percentile_50, :percentile_75])
    |> validate_required([:percentile_25, :percentile_50, :percentile_75])
  end
end
