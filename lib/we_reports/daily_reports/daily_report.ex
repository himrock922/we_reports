defmodule WeReports.DailyReports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :reporting_date, :utc_datetime
    field :memo, :string
    field :summary, :string
    many_to_many :articles, WeReports.Articles.Article, join_through: "articles_daily_reports", on_replace: :delete, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:memo, :summary])
    |> validate_required([:memo, :summary])
  end
end
