defmodule DailyReport.Articles.Article do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "article" do
    field :body, :string
    field :title, :string
    belongs_to :user, DailyReport.UserManager.User
    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
