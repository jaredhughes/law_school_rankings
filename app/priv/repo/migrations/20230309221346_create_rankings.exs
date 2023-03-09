defmodule App.Repo.Migrations.CreateRankings do
  use Ecto.Migration

  def change do
    create table(:rankings) do
      add :rank, :string, null: false
      add :school, references(:schools, on_delete: :nothing), null: false
      add :first_year_class, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:rankings, [:school])
    create index(:rankings, [:first_year_class])

    create unique_index(:rankings, [:school, :first_year_class])
  end
end
