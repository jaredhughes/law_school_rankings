defmodule App.RankingsTest do
  use App.DataCase
  import App.Factory
  alias App.Rankings

  describe "Rankings" do
    test "list_schools/0 returns schools" do
      insert!(:school)
      result = Rankings.list_schools()

      assert length(result) == 1
    end

    test "get_lsat_fact/1 returns 50th percentile message" do
      lsat_score = insert!(:lsat_score)
      result = Rankings.get_lsat_fact(lsat_score.school_id)

      assert result =~
               "In 2022, My school name had a 50th percentile LSAT score of #{lsat_score.percentile_50}"
    end
  end
end
