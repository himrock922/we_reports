use Mix.Config

# Configure your database
config :daily_report, DailyReport.Repo,
  username: "postgres",
  password: "",
  database: "travis_ci_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :daily_report, DailyReportWeb.Endpoint,
  http: [port: 5432],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn