defmodule WeReports.Repo.Migrations.CreateGroupsUsers do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :group_id, references(:groups)
      add :user_id, references(:users)
    end
    create index(:groups_users, [:group_id, :user_id])
  end
end
