defmodule WeReportsWeb.GroupControllerTest do
  use WeReportsWeb.ConnCase

  alias WeReports.{Groups, UserManager}

  @create_attrs %{description: "some description", name: "some name", type_name: "sponsor"}
  @create_user %{password: "some password", username: "some username"}
  @update_attrs %{description: "some updated description", name: "some updated name", type_name: "sponsor"}
  @invalid_attrs %{description: nil, name: nil, users: nil, type_name: "sponsor"}
  @blank_group_name_attrs %{description: "test", name: nil, users: nil, type_name: "sponsor"}
  @blank_group_description_attrs %{description: "test", name: nil, users: nil, type_name: "sponsor"}

  def fixture(:group) do
    {:ok, group} = Groups.create_group(@create_attrs)
    group
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@create_user)
      |> UserManager.create_user()
    user
  end

  describe "グループ一覧" do
    @tag :authenticated
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :index))
      assert html_response(conn, 200) =~ "グループ一覧"
    end
  end

  describe "グループ作成" do
    @tag :authenticated
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :new))
      assert html_response(conn, 200) =~ "新規グループ作成"
    end
  end

  describe "グループ新規作成" do
    @tag :authenticated
    test "グループ新規作成成功(所属ユーザなし)", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.group_path(conn, :show, id)

      conn = get(conn, Routes.group_path(conn, :show, id))
      assert html_response(conn, 200) =~ "some name"
      assert html_response(conn, 200) =~ "グループの作成に成功しました。"
    end

    @tag :authenticated
    test "グループ新規作成成功(所属ユーザあり)", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.group_path(conn, :create), group: %{description: "some description", name: "some name", type_name: "sponsor", groups_users: [user.id]})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.group_path(conn, :show, id)

      conn = get(conn, Routes.group_path(conn, :show, id))
      assert html_response(conn, 200) =~ "some name"
      assert html_response(conn, 200) =~ "グループの作成に成功しました。"
      group = Groups.get_group!(id)
      Enum.any?(group.users, fn u -> u.username === "some username" end) === true
    end

    @tag :authenticated
    test "グループ新規作成失敗(グループ名なし)", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @blank_group_name_attrs)
      assert html_response(conn, 200) =~ "グループの作成に失敗しました。"
    end

    @tag :authenticated
    test "グループ新規作成失敗(グループ概要なし)", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @blank_group_description_attrs)
      assert html_response(conn, 200) =~ "グループの作成に失敗しました。"
    end
  end

  describe "edit group" do
    setup [:create_group]

    @tag :authenticated
    test "renders form for editing chosen group", %{conn: conn, group: group} do
      conn = get(conn, Routes.group_path(conn, :edit, group))
      assert html_response(conn, 200) =~ "グループ編集"
    end
  end

  describe "update group" do
    setup [:create_group]

    @tag :authenticated
    test "redirects when data is valid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @update_attrs)
      assert redirected_to(conn) == Routes.group_path(conn, :show, group)

      conn = get(conn, Routes.group_path(conn, :show, group))
      assert html_response(conn, 200) =~ "some updated description"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @invalid_attrs)
      assert html_response(conn, 200) =~ "グループ編集"
    end
  end

  describe "delete group" do
    setup [:create_group]

    @tag :authenticated
    test "deletes chosen group", %{conn: conn, group: group} do
      conn = delete(conn, Routes.group_path(conn, :delete, group))
      assert redirected_to(conn) == Routes.group_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.group_path(conn, :show, group))
      end
    end
  end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end
end
