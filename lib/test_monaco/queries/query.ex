defmodule TestMonaco.Queries.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queries" do
    field :query, :string, default: ~S"this
    is
    default!!
    "

    timestamps()
  end

  @doc false
  def changeset(query, attrs) do
    query
    |> cast(attrs, [:query])
    |> validate_required([:query])
  end
end
