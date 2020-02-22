defmodule DailyReport.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DailyReport.UserManager.User

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
    has_many :articles, DailyReport.Articles.Article
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
