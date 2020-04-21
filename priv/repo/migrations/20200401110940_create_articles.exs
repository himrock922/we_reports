defmodule WeReports.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :work_time, :float
      add :title, :string
      add :body, :text
      timestamps()
    end
  end
end
