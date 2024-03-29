defmodule App.Schema.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schools" do
    field(:name, :string)
    has_many(:rankings, App.Schema.Ranking)

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
