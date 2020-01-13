defmodule DailyReport.Repo do
  use Ecto.Repo,
    otp_app: :daily_report,
    adapter: Ecto.Adapters.Postgres
end
