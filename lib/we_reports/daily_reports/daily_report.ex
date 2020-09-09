defmodule WeReports.DailyReports.DailyReport do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :reporting_date, :date
    field :memo, :string
    field :summary, :string
    has_many :articles, WeReports.Articles.Article, on_delete: :delete_all
    belongs_to :user, WeReports.UserManager.User
    timestamps()
  end

  @doc false
  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:reporting_date, :memo, :summary, :user_id])
    |> cast_assoc(:articles)
    |> validate_required([:user_id])
  end
end
