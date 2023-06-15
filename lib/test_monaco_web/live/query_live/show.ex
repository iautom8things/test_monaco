defmodule TestMonacoWeb.QueryLive.Show do
  use TestMonacoWeb, :live_view

  alias TestMonaco.Queries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:query, Queries.get_query!(id))}
  end

  defp page_title(:show), do: "Show Query"
  defp page_title(:edit), do: "Edit Query"
end
