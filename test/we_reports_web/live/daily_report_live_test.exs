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

  describe "Index" do
    setup [:create_daily_report]

    test "lists all daily_reports", %{conn: conn, daily_report: daily_report} do
      {:ok, _index_live, html} = live(conn, Routes.daily_report_index_path(conn, :index))

      assert html =~ "Listing Daily reports"
    end

    test "saves new daily_report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.daily_report_index_path(conn, :index))

      assert index_live |> element("a", "New Daily report") |> render_click() =~
        "New Daily report"

      assert_patch(index_live, Routes.daily_report_index_path(conn, :new))

      assert index_live
             |> form("#daily_report-form", daily_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#daily_report-form", daily_report: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.daily_report_index_path(conn, :index))

      assert html =~ "Daily report created successfully"
    end

    test "updates daily_report in listing", %{conn: conn, daily_report: daily_report} do
      {:ok, index_live, _html} = live(conn, Routes.daily_report_index_path(conn, :index))

      assert index_live |> element("#daily_report-#{daily_report.id} a", "Edit") |> render_click() =~
        "Edit Daily report"

      assert_patch(index_live, Routes.daily_report_index_path(conn, :edit, daily_report))

      assert index_live
             |> form("#daily_report-form", daily_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#daily_report-form", daily_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.daily_report_index_path(conn, :index))

      assert html =~ "Daily report updated successfully"
    end

    test "deletes daily_report in listing", %{conn: conn, daily_report: daily_report} do
      {:ok, index_live, _html} = live(conn, Routes.daily_report_index_path(conn, :index))

      assert index_live |> element("#daily_report-#{daily_report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_report-#{daily_report.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_report]

    test "displays daily_report", %{conn: conn, daily_report: daily_report} do
      {:ok, _show_live, html} = live(conn, Routes.daily_report_show_path(conn, :show, daily_report))

      assert html =~ "Show Daily report"
    end

    test "updates daily_report within modal", %{conn: conn, daily_report: daily_report} do
      {:ok, show_live, _html} = live(conn, Routes.daily_report_show_path(conn, :show, daily_report))

      assert show_live |> element("a", "Edit") |> render_click() =~
        "Edit Daily report"

      assert_patch(show_live, Routes.daily_report_show_path(conn, :edit, daily_report))

      assert show_live
             |> form("#daily_report-form", daily_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#daily_report-form", daily_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.daily_report_show_path(conn, :show, daily_report))

      assert html =~ "Daily report updated successfully"
    end
  end
end
