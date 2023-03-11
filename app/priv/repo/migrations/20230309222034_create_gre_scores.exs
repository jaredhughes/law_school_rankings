defmodule App.Repo.Migrations.CreateGreScores do
  use Ecto.Migration

  def change do
    create table(:gre_scores) do
      add :verbal_percentile_25, :integer, null: false
      add :verbal_percentile_50, :integer, null: false
      add :verbal_percentile_75, :integer, null: false
      add :quantitative_percentile_25, :integer, null: false
      add :quantitative_percentile_50, :integer, null: false
      add :quantitative_percentile_75, :integer, null: false
      add :written_percentile_25, :float, null: false
      add :written_percentile_50, :float, null: false
      add :written_percentile_75, :float, null: false
      add :school_id, references(:schools, on_delete: :nothing), null: false
      add :first_year_class_id, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:gre_scores, [:school_id])
    create index(:gre_scores, [:first_year_class_id])

    create unique_index(:gre_scores, [:school_id, :first_year_class_id])
  end
end
