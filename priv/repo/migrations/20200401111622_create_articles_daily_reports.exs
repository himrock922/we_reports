defmodule WeReports.Repo.Migrations.CreateArticlesDailyReports do
  use Ecto.Migration

  def change do
    create table(:articles_daily_reports) do
      add :article_id, references(:articles)
      add :daily_report_id, references(:daily_reports)
    end
    create index(:articles_daily_reports, [:article_id, :daily_report_id])
  end
end
