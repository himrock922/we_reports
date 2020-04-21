defmodule WeReports.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    field :body, :string
    field :work_time, :float
    many_to_many :daily_reports, WeReports.DailyReports.DailyReport, join_through: "articles_daily_reports"
    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:work_time, :body, :proposition])
    |> validate_required([:work_time, :body, :proposition])
  end
end
