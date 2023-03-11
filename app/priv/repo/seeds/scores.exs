alias App.Repo
alias App.Schema.{School, FirstYearClass, GpaScore, LsatScore, GreScore}

NimbleCSV.define(MyParser, separator: ",", escape: "\"")

"priv/repo/data/seed.csv"
|> File.stream!()
|> MyParser.parse_stream()
|> Stream.map(fn [
                   _rank,
                   school,
                   first_year_class,
                   l75,
                   l50,
                   l25,
                   g75,
                   g50,
                   g25,
                   gre75v,
                   gre50v,
                   gre25v,
                   gre75q,
                   gre50q,
                   gre25q,
                   gre75w,
                   gre50w,
                   gre25w
                 ]
                 when not is_nil(school) and not is_nil(first_year_class) ->
  with %School{id: school_id} <- Repo.get_by(School, name: school),
       %FirstYearClass{id: first_year_class_id} <-
         Repo.get_by(FirstYearClass, year: first_year_class) do
    %LsatScore{}
    |> LsatScore.changeset(%{
      percentile_25: l25,
      percentile_50: l50,
      percentile_75: l75,
      school_id: school_id,
      first_year_class_id: first_year_class_id
    })
    |> Repo.insert(on_conflict: :nothing)

    %GpaScore{}
    |> GpaScore.changeset(%{
      percentile_25: g25,
      percentile_50: g50,
      percentile_75: g75,
      school_id: school_id,
      first_year_class_id: first_year_class_id
    })
    |> Repo.insert(on_conflict: :nothing)

    %GreScore{}
    |> GreScore.changeset(%{
      verbal_percentile_25: gre25v,
      verbal_percentile_50: gre50v,
      verbal_percentile_75: gre75v,
      quantitative_percentile_25: gre25q,
      quantitative_percentile_50: gre50q,
      quantitative_percentile_75: gre75q,
      written_percentile_25: gre25w,
      written_percentile_50: gre50w,
      written_percentile_75: gre75w,
      school_id: school_id,
      first_year_class_id: first_year_class_id
    })
    |> Repo.insert(on_conflict: :nothing)
  else
    _ -> {:error, "Required entity not found. Skipping."}
  end
end)
|> Stream.run()
