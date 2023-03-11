defmodule App.Repo.Migrations.CreateLsatScores do
  use Ecto.Migration

  def change do
    create table(:lsat_scores) do
      add :percentile_25, :integer, null: false
      add :percentile_50, :integer, null: false
      add :percentile_75, :integer, null: false
      add :school_id, references(:schools, on_delete: :nothing), null: false
      add :first_year_class_id, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:lsat_scores, [:school_id])
    create index(:lsat_scores, [:first_year_class_id])

    create unique_index(:lsat_scores, [:school_id, :first_year_class_id])
  end
end
