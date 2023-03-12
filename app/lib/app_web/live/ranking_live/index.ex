defmodule AppWeb.RankingLive.Index do
  use AppWeb, :live_view
  alias App.Rankings

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, %{
       school: nil,
       school_options: Rankings.list_schools()
     })}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rankings")
  end

  @impl true
  def handle_event("search", %{"select_school" => school_id}, socket) do
    {:noreply,
     assign(socket, %{
       school: Rankings.get_school(school_id),
       scores: Rankings.get_scores(school_id)
     })}
  end
end
