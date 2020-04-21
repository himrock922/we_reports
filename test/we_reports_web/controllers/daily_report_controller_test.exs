defmodule WeReportsWeb.DailyReportControllerTest do
  use WeReportsWeb.ConnCase

  alias WeReports.DailyReports

  @create_attrs %{next_action: "some next_action", summary: "some summary"}
  @update_attrs %{next_action: "some updated next_action", summary: "some updated summary"}
  @invalid_attrs %{next_action: nil, summary: nil}

  def fixture(:daily_report) do
    {:ok, daily_report} = DailyReports.create_daily_report(@create_attrs)
    daily_report
  end

  describe "index" do
    test "lists all daily_reports", %{conn: conn} do
      conn = get(conn, Routes.daily_report_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Daily reports"
    end
  end

  describe "new daily_report" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.daily_report_path(conn, :new))
      assert html_response(conn, 200) =~ "New Daily report"
    end
  end

  describe "create daily_report" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.daily_report_path(conn, :create), daily_report: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.daily_report_path(conn, :show, id)

      conn = get(conn, Routes.daily_report_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Daily report"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.daily_report_path(conn, :create), daily_report: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Daily report"
    end
  end

  describe "edit daily_report" do
    setup [:create_daily_report]

    test "renders form for editing chosen daily_report", %{conn: conn, daily_report: daily_report} do
      conn = get(conn, Routes.daily_report_path(conn, :edit, daily_report))
      assert html_response(conn, 200) =~ "Edit Daily report"
    end
  end

  describe "update daily_report" do
    setup [:create_daily_report]

    test "redirects when data is valid", %{conn: conn, daily_report: daily_report} do
      conn = put(conn, Routes.daily_report_path(conn, :update, daily_report), daily_report: @update_attrs)
      assert redirected_to(conn) == Routes.daily_report_path(conn, :show, daily_report)

      conn = get(conn, Routes.daily_report_path(conn, :show, daily_report))
      assert html_response(conn, 200) =~ "some updated next_action"
    end

    test "renders errors when data is invalid", %{conn: conn, daily_report: daily_report} do
      conn = put(conn, Routes.daily_report_path(conn, :update, daily_report), daily_report: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Daily report"
    end
  end

  describe "delete daily_report" do
    setup [:create_daily_report]

    test "deletes chosen daily_report", %{conn: conn, daily_report: daily_report} do
      conn = delete(conn, Routes.daily_report_path(conn, :delete, daily_report))
      assert redirected_to(conn) == Routes.daily_report_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.daily_report_path(conn, :show, daily_report))
      end
    end
  end

  defp create_daily_report(_) do
    daily_report = fixture(:daily_report)
    {:ok, daily_report: daily_report}
  end
end
