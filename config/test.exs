use Mix.Config

# Configure your database
config :we_reports, WeReports.Repo,
  username: "we_reports",
  password: "we_reports",
  database: "we_reports_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :we_reports, WeReportsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :we_reports, WeReports.UserManager.Guardian,
       issuer: "we_reports",
       secret_key: "PwXCS/dDWeTI6t4m5W4AotvcsctOS1ziQexvfPuCLW24GoRQSiFzV3BZo0uk9sq1"