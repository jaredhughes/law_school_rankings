alias App.Repo
alias App.Schema.School

NimbleCSV.define(MyParser, separator: ",", escape: "\"")

"priv/repo/data/seed.csv"
|> File.stream!()
|> MyParser.parse_stream()
|> Stream.map(fn [_rank, school | _] ->
  %School{}
  |> School.changeset(%{
    name: school
  })
  |> Repo.insert(on_conflict: :nothing)
end)
|> Stream.run()
