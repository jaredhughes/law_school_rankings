defmodule App.Repo.Migrations.CreateFirstYearClasses do
  use Ecto.Migration

  def change do
    create table(:first_year_classes) do
      add :year, :integer, null: false

      timestamps()
    end

    create unique_index(:first_year_classes, [:year])
  end
end
