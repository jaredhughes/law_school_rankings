defmodule App.Repo.Migrations.CreateRankings do
  use Ecto.Migration

  def change do
    create table(:rankings) do
      add :rank, :string, null: false
      add :school_id, references(:schools, on_delete: :nothing), null: false
      add :first_year_class_id, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:rankings, [:school_id])
    create index(:rankings, [:first_year_class_id])

    create unique_index(:rankings, [:school_id, :first_year_class_id])
  end
end
