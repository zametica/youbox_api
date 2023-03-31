defmodule YouboxApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      YouboxApiWeb.Telemetry,
      # Start the Ecto repository
      YouboxApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: YouboxApi.PubSub},
      # Start the Endpoint (http/https)
      YouboxApiWeb.Endpoint
      # Start a worker by calling: YouboxApi.Worker.start_link(arg)
      # {YouboxApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YouboxApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YouboxApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
