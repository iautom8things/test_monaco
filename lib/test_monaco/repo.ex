defmodule TestMonaco.Repo do
  use Ecto.Repo,
    otp_app: :test_monaco,
    adapter: Ecto.Adapters.SQLite3
end
