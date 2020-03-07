defmodule DailyReport.Repo.Migrations.CreateGroups do
  use Ecto.Migration
  import EctoEnum
  defenum StatusEnum, :type, [:sponsor, :project]
  def change do
    StatusEnum.create_type
    create table(:groups) do
      add :name, :string
      add :description, :text
      add :type, StatusEnum.type()
      timestamps()
    end
    create unique_index(:groups, [:type])
  end
end
