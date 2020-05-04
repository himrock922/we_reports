# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :we_reports,
  ecto_repos: [WeReports.Repo]

# Configures the endpoint
config :we_reports, WeReportsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jRjf4mneV44QOyJ2g5DsII6xCWf/r60TB578wCCtgc5/v8xt7t8hhOum5v823owM",
  render_errors: [view: WeReportsWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: WeReportsWeb.PubSub,
  live_view: [signing_salt: "Cr6WEgZcclgy4D9F412DHpFDyW+iUmsF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :gettext, :default_locale, "ja"