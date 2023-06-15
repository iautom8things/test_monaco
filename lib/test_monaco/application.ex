defmodule TestMonaco.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestMonacoWeb.Telemetry,
      # Start the Ecto repository
      TestMonaco.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestMonaco.PubSub},
      # Start Finch
      {Finch, name: TestMonaco.Finch},
      # Start the Endpoint (http/https)
      TestMonacoWeb.Endpoint
      # Start a worker by calling: TestMonaco.Worker.start_link(arg)
      # {TestMonaco.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestMonaco.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestMonacoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
