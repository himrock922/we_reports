defmodule WeReports.Groups.Group do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :description, :string
    field :name, :string
    field :type_name, :string
    many_to_many :users, WeReports.UserManager.User, join_through: "groups_users", on_replace: :delete, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description, :type_name])
    |> validate_required([:name, :description, :type_name])
  end
end
