# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :namer,
  ecto_repos: [Namer.Repo]

# Configures the endpoint
config :namer, NamerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0XjPaAEHN2043rEWQQzWPA5fNwWYD9JsU6Z0v46LBSHHRBtmiJgjAGcnSYVTFtcl",
  render_errors: [view: NamerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Namer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :namer, gtm_id: System.get_env("GTM_ID")

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :filter_parameters, ~w(password secret)

config :strava,
  client_id: System.get_env("STRAVA_CLIENT_ID"),
  client_secret: System.get_env("STRAVA_CLIENT_SECRET"),
  redirect_uri: "http://localhost:4000/auth/strava/callback",
  webhook_uri: "https://localhost:4000/webhook",
  webhook_challenge: System.get_env("STRAVA_WEBHOOK_TOKEN")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
