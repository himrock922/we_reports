defmodule WeReports.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :work_time, :string
      add :title, :string
      add :body, :text
      add :daily_report_id, references(:daily_reports)
      timestamps()
    end
    create index(:articles, [:id, :daily_report_id])
  end
end
