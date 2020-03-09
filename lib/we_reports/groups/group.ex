defmodule WeReports.Groups.Group do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :description, :string
    field :name, :string
    many_to_many :users, WeReports.UserManager.User, join_through: "groups_users"
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
