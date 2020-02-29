defmodule DailyReport.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:article) do
      add :title, :string
      add :body, :text
      add :user_id, references(:users)
      timestamps()
    end

  end
end
