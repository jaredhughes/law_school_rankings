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
      add :school, references(:schools, on_delete: :nothing), null: false
      add :first_year_class, references(:first_year_classes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:gre_scores, [:school])
    create index(:gre_scores, [:first_year_class])

    create unique_index(:gre_scores, [:school, :first_year_class])
  end
end
