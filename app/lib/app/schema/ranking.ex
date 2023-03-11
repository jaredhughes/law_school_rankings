defmodule App.Schema.Ranking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rankings" do
    field(:rank, :string)
    belongs_to(:school, App.Schema.School)
    belongs_to(:first_year_class, App.Schema.FirstYearClass)

    timestamps()
  end

  @required_fields [
    :rank,
    :school_id,
    :first_year_class_id
  ]

  @doc false
  def changeset(ranking, attrs) do
    ranking
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
