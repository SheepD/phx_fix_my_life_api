# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fix_my_life,
  ecto_repos: [FixMyLife.Repo]

# Configures the endpoint
config :fix_my_life, FixMyLifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e8Rc/1IWZhqmd03zAyMO/ZdI98kcNlWwgpEPESHJSNh4Ic3dB21LiJ6aogBH+fxj",
  render_errors: [view: FixMyLifeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FixMyLife.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
