defmodule WeReportsWeb.GroupController do
  use WeReportsWeb, :controller

  alias WeReports.Groups
  alias WeReports.Groups.Group
  alias WeReports.UserManager

  def index(conn, _params) do
    groups = Groups.list_groups()
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    users = get_users()
    changeset = Groups.change_group(%Group{})
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"group" => group_params}) do
    users = get_users()
    case Groups.create_group(group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:success, "グループの作成に成功しました。")
        |> redirect(to: Routes.group_path(conn, :show, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    render(conn, "show.html", group: group)
  end

  def edit(conn, %{"id" => id}) do
    users = get_users()
    group = Groups.get_group!(id)
    changeset = Groups.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    users = get_users()
    group = Groups.get_group!(id)

    case Groups.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:success, "グループの更新に成功しました。")
        |> redirect(to: Routes.group_path(conn, :show, group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    {:ok, _group} = Groups.delete_group(group)

    conn
    |> put_flash(:success, "グループの削除に成功しました。")
    |> redirect(to: Routes.group_path(conn, :index))
  end

  defp get_users, do: UserManager.list_users()
end
