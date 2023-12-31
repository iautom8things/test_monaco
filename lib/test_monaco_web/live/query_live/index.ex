defmodule TestMonacoWeb.QueryLive.Index do
  use TestMonacoWeb, :live_view

  alias TestMonaco.Queries
  alias TestMonaco.Queries.Query

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :queries, Queries.list_queries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Query")
    |> assign(:query, Queries.get_query!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Query")
    |> assign(:query, %Query{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Queries")
    |> assign(:query, nil)
  end

  @impl true
  def handle_info({TestMonacoWeb.QueryLive.FormComponent, {:saved, query}}, socket) do
    {:noreply, stream_insert(socket, :queries, query)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    query = Queries.get_query!(id)
    {:ok, _} = Queries.delete_query(query)

    {:noreply, stream_delete(socket, :queries, query)}
  end
end
