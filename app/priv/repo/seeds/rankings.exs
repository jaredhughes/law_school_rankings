alias App.Repo
alias App.Schema.{School, FirstYearClass, Ranking}
require Logger

NimbleCSV.define(MyParser, separator: ",", escape: "\"")

"priv/repo/data/seed.csv"
|> File.stream!()
|> MyParser.parse_stream()
|> Stream.map(fn [
                   rank,
                   school,
                   first_year_class | _
                 ]
                 when not is_nil(school) and not is_nil(first_year_class) ->
  with %School{id: school_id} <- Repo.get_by(School, name: school),
       %FirstYearClass{id: first_year_class_id} <-
         Repo.get_by(FirstYearClass, year: first_year_class) do
    %Ranking{}
    |> Ranking.changeset(%{
      rank: rank,
      school_id: school_id,
      first_year_class_id: first_year_class_id
    })
    |> Repo.insert(on_conflict: :nothing)
  else
    _ -> {:error, "Required entity not found. Skipping."}
  end
end)
|> Stream.run()
