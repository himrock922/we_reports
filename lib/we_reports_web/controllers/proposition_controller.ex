defmodule WeReportsWeb.PropositionController do
  use WeReportsWeb, :controller

  alias WeReports.Groups
  alias WeReports.Propositions
  alias WeReports.Propositions.Proposition
  import Ecto

  def index(conn, %{"group_id" => group_id}) do
    group = Propositions.list_propositions(group_id)
    render(conn, "index.html", group: group)
  end

  def new(conn, %{"group_id" => group_id}) do
    group = Groups.get_group!(group_id)
    changeset =
      Ecto.build_assoc(group, :propositions)
      |> WeReports.Propositions.Proposition.changeset(%{})
    render(conn, "new.html", changeset: changeset, group: group)
  end

  def create(conn, %{"proposition" => proposition_params}) do
    group = Groups.get_group!(proposition_params["group_id"])
    case Propositions.create_proposition(proposition_params) do
      {:ok, proposition} ->
        conn
        |> put_flash(:success, "案件の作成に成功しました。")
        |> redirect(to: Routes.group_proposition_path(conn, :show, proposition.group_id, proposition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, group: group)
    end
  end

  def show(conn, %{"group_id" => group_id, "id" => id}) do
    proposition = Propositions.get_proposition!(id)
    render(conn, "show.html", proposition: proposition)
  end

  def edit(conn, %{"id" => id}) do
    proposition = Propositions.get_proposition!(id)
    changeset = Propositions.change_proposition(proposition)
    render(conn, "edit.html", proposition: proposition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "proposition" => proposition_params}) do
    proposition = Propositions.get_proposition!(id)

    case Propositions.update_proposition(proposition, proposition_params) do
      {:ok, proposition} ->
        conn
        |> put_flash(:success, "案件の更新に成功しました。")
        |> redirect(to: Routes.group_proposition_path(conn, :show, proposition.group_id, proposition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", proposition: proposition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    proposition = Propositions.get_proposition!(id)
    {:ok, _proposition} = Propositions.delete_proposition(proposition)

    conn
    |> put_flash(:success, "案件の削除に成功しました。")
    |> redirect(to: Routes.group_proposition_path(conn, :index, proposition.group_id))
  end
end
