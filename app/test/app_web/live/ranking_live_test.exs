defmodule AppWeb.RankingLiveTest do
  use AppWeb.ConnCase

  import Phoenix.LiveViewTest
  import App.RankingsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_ranking(_) do
    ranking = ranking_fixture()
    %{ranking: ranking}
  end

  describe "Index" do
    setup [:create_ranking]

    test "lists all rankings", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/rankings")

      assert html =~ "Listing Rankings"
    end

    test "saves new ranking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/rankings")

      assert index_live |> element("a", "New Ranking") |> render_click() =~
               "New Ranking"

      assert_patch(index_live, ~p"/rankings/new")

      assert index_live
             |> form("#ranking-form", ranking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ranking-form", ranking: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rankings")

      html = render(index_live)
      assert html =~ "Ranking created successfully"
    end

    test "updates ranking in listing", %{conn: conn, ranking: ranking} do
      {:ok, index_live, _html} = live(conn, ~p"/rankings")

      assert index_live |> element("#rankings-#{ranking.id} a", "Edit") |> render_click() =~
               "Edit Ranking"

      assert_patch(index_live, ~p"/rankings/#{ranking}/edit")

      assert index_live
             |> form("#ranking-form", ranking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ranking-form", ranking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rankings")

      html = render(index_live)
      assert html =~ "Ranking updated successfully"
    end

    test "deletes ranking in listing", %{conn: conn, ranking: ranking} do
      {:ok, index_live, _html} = live(conn, ~p"/rankings")

      assert index_live |> element("#rankings-#{ranking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rankings-#{ranking.id}")
    end
  end

  describe "Show" do
    setup [:create_ranking]

    test "displays ranking", %{conn: conn, ranking: ranking} do
      {:ok, _show_live, html} = live(conn, ~p"/rankings/#{ranking}")

      assert html =~ "Show Ranking"
    end

    test "updates ranking within modal", %{conn: conn, ranking: ranking} do
      {:ok, show_live, _html} = live(conn, ~p"/rankings/#{ranking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ranking"

      assert_patch(show_live, ~p"/rankings/#{ranking}/show/edit")

      assert show_live
             |> form("#ranking-form", ranking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ranking-form", ranking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/rankings/#{ranking}")

      html = render(show_live)
      assert html =~ "Ranking updated successfully"
    end
  end
end
