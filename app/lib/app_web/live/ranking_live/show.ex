defmodule AppWeb.RankingLive.Show do
  use AppWeb, :live_view

  alias App.Rankings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ranking, Rankings.get_ranking!(id))}
  end

  defp page_title(:show), do: "Show Ranking"
  defp page_title(:edit), do: "Edit Ranking"
end
