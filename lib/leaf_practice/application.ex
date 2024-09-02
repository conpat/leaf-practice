defmodule LeafPractice.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeafPracticeWeb.Telemetry,
      LeafPractice.Repo,
      {DNSCluster, query: Application.get_env(:leaf_practice, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LeafPractice.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LeafPractice.Finch},
      # Start a worker by calling: LeafPractice.Worker.start_link(arg)
      # {LeafPractice.Worker, arg},
      # Start to serve requests, typically the last entry
      LeafPracticeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeafPractice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeafPracticeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
