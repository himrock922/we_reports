defmodule DailyReportWeb.PageController do
  use DailyReportWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
