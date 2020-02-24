use Mix.Config

# Configure your database
config :daily_report, DailyReport.Repo,
  username: "daily_report",
  password: "daily_report",
  database: "daily_report_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :daily_report, DailyReportWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :daily_report, DailyReport.UserManager.Guardian,
       issuer: "daily_report",
       secret_key: "PwXCS/dDWeTI6t4m5W4AotvcsctOS1ziQexvfPuCLW24GoRQSiFzV3BZo0uk9sq1"