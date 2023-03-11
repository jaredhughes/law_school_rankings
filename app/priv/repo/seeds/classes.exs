alias App.Repo
alias App.Schema.FirstYearClass

NimbleCSV.define(MyParser, separator: ",", escape: "\"")

"priv/repo/data/seed.csv"
|> File.stream!()
|> MyParser.parse_stream()
|> Stream.map(fn [_rank, _school, year | _] ->
  %FirstYearClass{}
  |> FirstYearClass.changeset(%{
    year: year
  })
  |> Repo.insert(on_conflict: :nothing)
end)
|> Stream.run()
