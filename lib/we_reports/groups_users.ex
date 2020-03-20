defmodule WeReports.GroupsUsers do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups_users" do
    belongs_to :group, WeReports.Groups.Group
    belongs_to :user, WeReports.UserManager.User
  end

  def changeset(groups_users, params \\ %{}) do
    groups_users
    |> cast(params, [:group_id, :user_id])
    |> validate_required([:group_id, :user_id])
  end
end
