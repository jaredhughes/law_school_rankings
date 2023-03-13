defmodule App.Factory do
  alias App.Repo

  def build(:school) do
    %App.Schema.School{name: "My school name"}
  end

  def build(:first_year_class) do
    %App.Schema.FirstYearClass{year: 2022}
  end

  def build(:ranking) do
    %App.Schema.Ranking{
      rank: 1,
      school: build(:school),
      first_year_class: build(:first_year_class)
    }
  end

  def build(:lsat_score) do
    %App.Schema.LsatScore{
      school: build(:school),
      first_year_class: build(:first_year_class),
      percentile_25: 150,
      percentile_50: 160,
      percentile_75: 170
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
