defmodule WeReportsWeb.PropositionControllerTest do
  use WeReportsWeb.ConnCase

  alias WeReports.Propositions

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:proposition) do
    {:ok, proposition} = Propositions.create_proposition(@create_attrs)
    proposition
  end

  describe "index" do
    test "lists all propositions", %{conn: conn} do
      conn = get(conn, Routes.proposition_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Propositions"
    end
  end

  describe "new proposition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.proposition_path(conn, :new))
      assert html_response(conn, 200) =~ "New Proposition"
    end
  end

  describe "create proposition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.proposition_path(conn, :create), proposition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.proposition_path(conn, :show, id)

      conn = get(conn, Routes.proposition_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Proposition"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.proposition_path(conn, :create), proposition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Proposition"
    end
  end

  describe "edit proposition" do
    setup [:create_proposition]

    test "renders form for editing chosen proposition", %{conn: conn, proposition: proposition} do
      conn = get(conn, Routes.proposition_path(conn, :edit, proposition))
      assert html_response(conn, 200) =~ "Edit Proposition"
    end
  end

  describe "update proposition" do
    setup [:create_proposition]

    test "redirects when data is valid", %{conn: conn, proposition: proposition} do
      conn = put(conn, Routes.proposition_path(conn, :update, proposition), proposition: @update_attrs)
      assert redirected_to(conn) == Routes.proposition_path(conn, :show, proposition)

      conn = get(conn, Routes.proposition_path(conn, :show, proposition))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, proposition: proposition} do
      conn = put(conn, Routes.proposition_path(conn, :update, proposition), proposition: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Proposition"
    end
  end

  describe "delete proposition" do
    setup [:create_proposition]

    test "deletes chosen proposition", %{conn: conn, proposition: proposition} do
      conn = delete(conn, Routes.proposition_path(conn, :delete, proposition))
      assert redirected_to(conn) == Routes.proposition_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.proposition_path(conn, :show, proposition))
      end
    end
  end

  defp create_proposition(_) do
    proposition = fixture(:proposition)
    {:ok, proposition: proposition}
  end
end
