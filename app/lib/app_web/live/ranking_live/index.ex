defmodule AppWeb.RankingLive.Index do
  use AppWeb, :live_view

  alias App.Rankings
  alias App.Schema.Ranking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :rankings, Rankings.list_rankings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ranking")
    |> assign(:ranking, Rankings.get_ranking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ranking")
    |> assign(:ranking, %Ranking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rankings")
    |> assign(:ranking, nil)
  end

  @impl true
  def handle_info({AppWeb.RankingLive.FormComponent, {:saved, ranking}}, socket) do
    {:noreply, stream_insert(socket, :rankings, ranking)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ranking = Rankings.get_ranking!(id)
    {:ok, _} = Rankings.delete_ranking(ranking)

    {:noreply, stream_delete(socket, :rankings, ranking)}
  end
end
