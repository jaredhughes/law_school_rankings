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
       scores: Rankings.get_scores(school_id),
       fact: Rankings.get_lsat_fact(school_id),
       rankings_by_year: Rankings.rankings_by_year(school_id)
     })}
  end

  def score_cell(assigns) do
    bg_class =
      case assigns.percentile do
        25 -> "bg-sky-400"
        50 -> "bg-sky-500"
        75 -> "bg-sky-600"
      end

    ~H"""
    <div class={"#{bg_class} text-center rounded-lg text-white"}>
      <div class="bg-slate-700 rounded-t-lg p-2 text-white uppercase text-sm font-semibold">
        <%= @percentile %>th Percentile
      </div>
      <div class="text-[30px] p-5 font-bold"><%= @data %></div>
    </div>
    """
  end
end
