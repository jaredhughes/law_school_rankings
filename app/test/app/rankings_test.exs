defmodule App.RankingsTest do
  use App.DataCase

  alias App.Rankings

  describe "rankings" do
    alias App.Schema.Ranking

    import App.RankingsFixtures

    @invalid_attrs %{}

    test "list_rankings/0 returns all rankings" do
      ranking = ranking_fixture()
      assert Rankings.list_rankings() == [ranking]
    end

    test "get_ranking!/1 returns the ranking with given id" do
      ranking = ranking_fixture()
      assert Rankings.get_ranking!(ranking.id) == ranking
    end

    test "create_ranking/1 with valid data creates a ranking" do
      valid_attrs = %{}

      assert {:ok, %Ranking{} = ranking} = Rankings.create_ranking(valid_attrs)
    end

    test "create_ranking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rankings.create_ranking(@invalid_attrs)
    end

    test "update_ranking/2 with valid data updates the ranking" do
      ranking = ranking_fixture()
      update_attrs = %{}

      assert {:ok, %Ranking{} = ranking} = Rankings.update_ranking(ranking, update_attrs)
    end

    test "update_ranking/2 with invalid data returns error changeset" do
      ranking = ranking_fixture()
      assert {:error, %Ecto.Changeset{}} = Rankings.update_ranking(ranking, @invalid_attrs)
      assert ranking == Rankings.get_ranking!(ranking.id)
    end

    test "delete_ranking/1 deletes the ranking" do
      ranking = ranking_fixture()
      assert {:ok, %Ranking{}} = Rankings.delete_ranking(ranking)
      assert_raise Ecto.NoResultsError, fn -> Rankings.get_ranking!(ranking.id) end
    end

    test "change_ranking/1 returns a ranking changeset" do
      ranking = ranking_fixture()
      assert %Ecto.Changeset{} = Rankings.change_ranking(ranking)
    end
  end
end
