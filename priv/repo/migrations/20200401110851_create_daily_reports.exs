defmodule WeReports.Repo.Migrations.CreateDailyReports do
  use Ecto.Migration

  def change do
    create table(:daily_reports) do
      add :reporting_date, :utc_datetime
      add :summary, :text
      add :memo, :text
      add :user_id, references(:users)
      timestamps()
    end
    create index(:daily_reports, [:id, :user_id])
  end
end
