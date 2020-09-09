defmodule WeReportsWeb.DailyReportControllerTest do
  use WeReportsWeb.ConnCase

  alias WeReports.{DailyReports, UserManager}

  @create_attrs %{next_action: "some next_action", summary: "some summary"}
  @create_user %{password: "some password", username: "some username"}

  def fixture(:daily_report) do
    {:ok, daily_report} = DailyReports.create_daily_report(@create_attrs)
    daily_report
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@create_user)
      |> UserManager.create_user()
    user
  end

  describe "日報一覧" do
    @tag :authenticated
    test "lists all daily_reports", %{conn: conn} do
      conn = get(conn, Routes.daily_report_path(conn, :index))
      assert html_response(conn, 200) =~ "日報一覧"
    end
  end

  describe "日報新規作成" do
    @tag :authenticated
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.daily_report_path(conn, :new))
      assert html_response(conn, 200) =~ "新規日報作成"
    end
  end

  describe "日報詳細" do
    setup [:create_daily_report]
    @tag :authenticated
    test "renders form", %{conn: conn, daily_report: daily_report} do
      conn = get(conn, Routes.daily_report_path(conn, :show, daily_report))
      assert html_response(conn, 200) =~ "some summary"
    end
  end

  describe "日報削除" do
    setup [:create_daily_report]
    @tag :authenticated
    test "deletes chosen daily_report", %{conn: conn, daily_report: daily_report} do
      conn = delete(conn, Routes.daily_report_path(conn, :delete, daily_report))
      assert redirected_to(conn) == Routes.daily_report_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.daily_report_path(conn, :show, daily_report))
      end
    end
  end

  defp create_daily_report(_) do
    user = user_fixture()
    add_user_create_attrs = Map.merge(@create_attrs, %{user_id: user.id})
    {:ok, daily_report} = DailyReports.create_daily_report(add_user_create_attrs)
    {:ok, daily_report: daily_report}
  end
end
