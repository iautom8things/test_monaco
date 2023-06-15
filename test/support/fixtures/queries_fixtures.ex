defmodule TestMonaco.QueriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestMonaco.Queries` context.
  """

  @doc """
  Generate a query.
  """
  def query_fixture(attrs \\ %{}) do
    {:ok, query} =
      attrs
      |> Enum.into(%{
        query: "some query"
      })
      |> TestMonaco.Queries.create_query()

    query
  end
end
