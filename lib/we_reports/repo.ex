defmodule WeReports.Repo do
  use Ecto.Repo,
    otp_app: :we_reports,
    adapter: Ecto.Adapters.Postgres
end
