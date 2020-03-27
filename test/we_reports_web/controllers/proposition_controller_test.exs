defmodule WeReportsWeb.PropositionControllerTest do
  use WeReportsWeb.ConnCase

  alias WeReports.{Groups, Propositions}

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}
  @create_group %{description: "some description", name: "some name", type_name: "sponsor"}

  def fixture(:proposition) do
    {:ok, proposition} = Propositions.create_proposition(@create_attrs)
    proposition
  end

  def fixture(:group) do
    {:ok, group} = Groups.create_group(@create_group)
    group
  end

  def fixture(:proposition_group) do
    {:ok, proposition} = Propositions.create_proposition(@create_attrs)
    proposition
  end

  describe "案件一覧" do
    setup [:create_group]
    @tag :authenticated
    test "グループが存在すれば案件一覧のアクセスに成功", %{conn: conn, group: group} do
      conn = get(conn, Routes.group_proposition_path(conn, :index, group.id))
      assert html_response(conn, 200) =~ "案件一覧"
    end
    @tag :authenticated
    test "グループが存在しなければ案件一覧のアクセスに失敗", %{conn: conn} do
      conn = get(conn, Routes.group_proposition_path(conn, :index, 0))
      assert html_response(conn, 404) =~ "Page not found"
    end
  end

  describe "案件の新規作成" do
    setup [:create_group]
    @tag :authenticated
    test "renders form", %{conn: conn, group: group} do
      conn = get(conn, Routes.group_proposition_path(conn, :new, group.id))
      assert html_response(conn, 200) =~ "some nameに関する案件の新規作成"
    end
  end

  describe "案件新規作成リクエスト" do
    setup [:create_group]
    @tag :authenticated
    test "新規作成(成功)", %{conn: conn, group: group} do
      add_group_create_attrs = Map.merge(@create_attrs, %{group_id: group.id})
      conn = post(conn, Routes.group_proposition_path(conn, :create, group.id), proposition: add_group_create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.group_proposition_path(conn, :show, group.id, id)

      conn = get(conn, Routes.group_proposition_path(conn, :show, group.id, id))
      assert html_response(conn, 200) =~ "案件の作成に成功しました。"
    end

    @tag :authenticated
    test "新規作成(失敗)", %{conn: conn, group: group} do
      add_group_invalid_attrs = Map.merge(@invalid_attrs, %{group_id: group.id})
      conn = post(conn, Routes.group_proposition_path(conn, :create, group.id), proposition: add_group_invalid_attrs)
      assert html_response(conn, 200) =~ "案件の作成に失敗しました。エラー部分を修正し再度案件の作成をお願いします。"
    end
  end

  describe "案件編集" do
    setup [:create_proposition]
    @tag :authenticated
    test "renders form for editing chosen proposition", %{conn: conn, proposition: proposition} do
      conn = get(conn, Routes.group_proposition_path(conn, :edit, proposition.group_id, proposition.id))
      assert html_response(conn, 200) =~ "some name some nameの編集"
    end
  end

  describe "案件更新" do
    setup [:create_proposition]
    @tag :authenticated
    test "案件更新(成功)", %{conn: conn, proposition: proposition} do
      conn = put(conn, Routes.group_proposition_path(conn, :update, proposition.group_id, proposition.id), proposition: @update_attrs)
      assert redirected_to(conn) == Routes.group_proposition_path(conn, :show, proposition.group_id, proposition.id)

      conn = get(conn, Routes.group_proposition_path(conn, :show, proposition.group_id, proposition.id))
      assert html_response(conn, 200) =~ "some updated description"
    end

    @tag :authenticated
    test "案件更新(失敗)", %{conn: conn, proposition: proposition} do
      conn = put(conn, Routes.group_proposition_path(conn, :update, proposition.group_id, proposition.id), proposition: @invalid_attrs)
      assert html_response(conn, 200) =~ "案件の作成に失敗しました。エラー部分を修正し再度案件の作成をお願いします。"
    end
  end

  describe "案件削除" do
    setup [:create_proposition]
    @tag :authenticated
    test "案件削除(成功)", %{conn: conn, proposition: proposition} do
      conn = delete(conn, Routes.group_proposition_path(conn, :delete, proposition.group_id, proposition.id))
      assert redirected_to(conn) == Routes.group_proposition_path(conn, :index, proposition.group_id)
      assert_error_sent 404, fn ->
        get(conn, Routes.group_proposition_path(conn, :show, proposition.group_id, proposition.id))
      end
    end
  end

  defp create_proposition(_) do
    group = fixture(:group)
    add_group_create_attrs = Map.merge(@create_attrs, %{group_id: group.id})
    {:ok, proposition} = Propositions.create_proposition(add_group_create_attrs)
    {:ok, proposition: proposition}
  end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end
end
