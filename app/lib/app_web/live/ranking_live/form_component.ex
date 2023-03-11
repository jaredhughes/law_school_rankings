defmodule AppWeb.RankingLive.FormComponent do
  use AppWeb, :live_component

  alias App.Rankings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage ranking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="ranking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Ranking</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{ranking: ranking} = assigns, socket) do
    changeset = Rankings.change_ranking(ranking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"ranking" => ranking_params}, socket) do
    changeset =
      socket.assigns.ranking
      |> Rankings.change_ranking(ranking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"ranking" => ranking_params}, socket) do
    save_ranking(socket, socket.assigns.action, ranking_params)
  end

  defp save_ranking(socket, :edit, ranking_params) do
    case Rankings.update_ranking(socket.assigns.ranking, ranking_params) do
      {:ok, ranking} ->
        notify_parent({:saved, ranking})

        {:noreply,
         socket
         |> put_flash(:info, "Ranking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_ranking(socket, :new, ranking_params) do
    case Rankings.create_ranking(ranking_params) do
      {:ok, ranking} ->
        notify_parent({:saved, ranking})

        {:noreply,
         socket
         |> put_flash(:info, "Ranking created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
