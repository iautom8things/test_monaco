defmodule TestMonacoWeb.QueryLive.FormComponent do
  use TestMonacoWeb, :live_component

  alias TestMonaco.Queries

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage query records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="query-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:query]} type="text" label="Query" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Query</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{query: query} = assigns, socket) do
    changeset = Queries.change_query(query)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"query" => query_params}, socket) do
    changeset =
      socket.assigns.query
      |> Queries.change_query(query_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"query" => query_params}, socket) do
    save_query(socket, socket.assigns.action, query_params)
  end

  defp save_query(socket, :edit, query_params) do
    case Queries.update_query(socket.assigns.query, query_params) do
      {:ok, query} ->
        notify_parent({:saved, query})

        {:noreply,
         socket
         |> put_flash(:info, "Query updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_query(socket, :new, query_params) do
    case Queries.create_query(query_params) do
      {:ok, query} ->
        notify_parent({:saved, query})

        {:noreply,
         socket
         |> put_flash(:info, "Query created successfully")
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
