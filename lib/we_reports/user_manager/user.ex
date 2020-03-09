defmodule WeReports.UserManager.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias WeReports.UserManager.User

  schema "users" do
    field :password, :string
    field :username, :string
    many_to_many :groups, WeReports.Groups.Group, join_through: "groups_users"
    timestamps()
  end

  @doc false
  alias Argon2

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
