defmodule WeReports.DailyReports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :reporting_date, :utc_datetime
    field :memo, :string
    field :summary, :string
    many_to_many :articles, WeReports.Articles.Article, join_through: "articles_daily_reports", on_replace: :delete, on_delete: :delete_all
    belongs_to :user, WeReports.UserManager.User
    timestamps()
  end

  @doc false
  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:reporting_date, :memo, :summary, :user_id])
    |> validate_required([:user_id])
  end
end
