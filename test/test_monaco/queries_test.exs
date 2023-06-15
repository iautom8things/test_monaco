defmodule TestMonaco.QueriesTest do
  use TestMonaco.DataCase

  alias TestMonaco.Queries

  describe "queries" do
    alias TestMonaco.Queries.Query

    import TestMonaco.QueriesFixtures

    @invalid_attrs %{query: nil}

    test "list_queries/0 returns all queries" do
      query = query_fixture()
      assert Queries.list_queries() == [query]
    end

    test "get_query!/1 returns the query with given id" do
      query = query_fixture()
      assert Queries.get_query!(query.id) == query
    end

    test "create_query/1 with valid data creates a query" do
      valid_attrs = %{query: "some query"}

      assert {:ok, %Query{} = query} = Queries.create_query(valid_attrs)
      assert query.query == "some query"
    end

    test "create_query/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Queries.create_query(@invalid_attrs)
    end

    test "update_query/2 with valid data updates the query" do
      query = query_fixture()
      update_attrs = %{query: "some updated query"}

      assert {:ok, %Query{} = query} = Queries.update_query(query, update_attrs)
      assert query.query == "some updated query"
    end

    test "update_query/2 with invalid data returns error changeset" do
      query = query_fixture()
      assert {:error, %Ecto.Changeset{}} = Queries.update_query(query, @invalid_attrs)
      assert query == Queries.get_query!(query.id)
    end

    test "delete_query/1 deletes the query" do
      query = query_fixture()
      assert {:ok, %Query{}} = Queries.delete_query(query)
      assert_raise Ecto.NoResultsError, fn -> Queries.get_query!(query.id) end
    end

    test "change_query/1 returns a query changeset" do
      query = query_fixture()
      assert %Ecto.Changeset{} = Queries.change_query(query)
    end
  end
end
