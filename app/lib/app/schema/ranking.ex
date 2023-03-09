defmodule App.Schema.Ranking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rankings" do
    field :rank, :string
    field :school, :id
    field :first_year_class, :id

    timestamps()
  end

  @doc false
  def changeset(ranking, attrs) do
    ranking
    |> cast(attrs, [:rank])
    |> validate_required([:rank])
  end
end
