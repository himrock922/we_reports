defmodule WeReportsWeb.DailyReportLiveTest do
  use WeReportsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias WeReports.DailyReports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:daily_report) do
    {:ok, daily_report} = DailyReports.create_daily_report(@create_attrs)
    daily_report
  end

  defp create_daily_report(_) do
    daily_report = fixture(:daily_report)
    %{daily_report: daily_report}
  end


end
