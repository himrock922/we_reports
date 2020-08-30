defmodule WeReports.ArticlesDailyReports do
    @moduledoc false
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "articles_daily_reports" do
      belongs_to :article, WeReports.Articles.Article
      belongs_to :daily_report, WeReports.DailyReports.DailyReport
    end
  
end  