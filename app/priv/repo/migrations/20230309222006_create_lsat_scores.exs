defmodule App.Repo.Migrations.CreateLsatScores do
  use Ecto.Migration

  def change do
    create table(:lsat_scores) do
      add :percentile_25, :integer, null: false
      add :percentile_50, :integer, null: false
      add :percentile_75, :integer, null: false
      add :school, references(:schools, on_delete: :nothing), null: false
      add :first_year_class, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:lsat_scores, [:school])
    create index(:lsat_scores, [:first_year_class])

    create unique_index(:lsat_scores, [:school, :first_year_class])
  end
end
