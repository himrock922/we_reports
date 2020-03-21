use Mix.Config

# Configure your database
config :we_reports, WeReports.Repo,
  username: "postgres",
  password: "",
  database: "travis_ci_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :we_reports, WeReportsWeb.Endpoint,
  http: [port: 5432],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :we_reports, WeReports.UserManager.Guardian,
       issuer: "we_reports",
       secret_key: "DU6N1a+1h/n2pTKaVmfkeuOBkgh2wJI9a1q94w3/3S6jP4vvOQYxGDBdtRXUXh03"