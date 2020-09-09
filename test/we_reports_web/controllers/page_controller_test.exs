defmodule WeReportsWeb.PageControllerTest do
  use WeReportsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "WeReportsは、日々の振り返りをちょっぴりリッチに、提出できるシステムです"
  end
end
