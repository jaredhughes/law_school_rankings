defmodule App.Repo.Migrations.CreateGpaScores do
  use Ecto.Migration

  def change do
    create table(:gpa_scores) do
      add :percentile_25, :float, null: false
      add :percentile_50, :float, null: false
      add :percentile_75, :float, null: false
      add :school, references(:schools, on_delete: :nothing), null: false
      add :first_year_class, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:gpa_scores, [:school])
    create index(:gpa_scores, [:first_year_class])

    create unique_index(:gpa_scores, [:school, :first_year_class])
  end
end
