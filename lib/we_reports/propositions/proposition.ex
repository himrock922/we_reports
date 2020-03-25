defmodule WeReports.Propositions.Proposition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "propositions" do
    field :description, :string
    field :name, :string
    belongs_to :group, WeReports.Groups.Group
    has_many :items, WeReports.Items.Item, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(proposition, attrs) do
    proposition
    |> cast(attrs, [:name, :description, :group_id])
    |> validate_required([:name, :description, :group_id])
  end

end
