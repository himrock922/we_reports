defmodule DailyReportWeb.PageControllerTest do
  use DailyReportWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "これは、日々の振り返りをちょっぴりリッチに、計測できるシステムです"
  end
end
