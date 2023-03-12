defmodule App.Schema.FirstYearClass do
  use Ecto.Schema
  import Ecto.Changeset

  schema "first_year_classes" do
    field(:year, :integer)
    has_many(:rankings, App.Schema.Ranking)

    timestamps()
  end

  @doc false
  def changeset(first_year_class, attrs) do
    first_year_class
    |> cast(attrs, [:year])
    |> validate_required([:year])
  end
end
