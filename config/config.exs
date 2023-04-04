# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :youbox_api,
  ecto_repos: [YouboxApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :youbox_api, YouboxApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: YouboxApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: YouboxApi.PubSub,
  live_view: [signing_salt: "KWdxliqE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :youbox_api, YouboxApiWeb.Auth.Guardian,
    issuer: "youbox_api",
    secret_key: "o7iHTWEdHphm0/1azFxOQa2pJEZVf7wpMm8qNCVpnmJYo7ABaMdlj38WZ0TBVQbZ"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
