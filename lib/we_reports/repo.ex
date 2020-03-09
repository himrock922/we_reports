defmodule WeReports.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :we_reports,
    adapter: Ecto.Adapters.Postgres
end
