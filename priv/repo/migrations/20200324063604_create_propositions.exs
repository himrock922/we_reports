defmodule WeReports.Repo.Migrations.CreatePropositions do
  use Ecto.Migration

  def change do
    create table(:propositions) do
      add :name, :string
      add :description, :text
      add :group_id, references(:groups)
      timestamps()
    end
    create index(:propositions, [:group_id, :id])
  end
end
