defmodule WeReportsWeb.DailyReportController do
  use WeReportsWeb, :controller

  alias WeReports.DailyReports
  alias WeReports.DailyReports.DailyReport
  alias WeReports.UserManager.Guardian
  alias WeReports.UserManager

  require IEx

  def index(conn, _params) do
    user = Guardian.current_user(conn)
    daily_reports = DailyReports.list_daily_reports(user.id)
    render(conn, "index.html", daily_reports: daily_reports, user: user)
  end

  def create(conn, %{"daily_report" => daily_report_params}) do
    case DailyReports.create_daily_report(daily_report_params) do
      {:ok, daily_report} ->
        conn
        |> put_flash(:info, "Daily report created successfully.")
        |> redirect(to: Routes.daily_report_path(conn, :show, daily_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    daily_report = DailyReports.get_daily_report!(id)
    render(conn, "show.html", daily_report: daily_report)
  end

  def edit(conn, %{"id" => id}) do
    daily_report = DailyReports.get_daily_report!(id)
    changeset = DailyReports.change_daily_report(daily_report)
    render(conn, "edit.html", daily_report: daily_report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "daily_report" => daily_report_params}) do
    daily_report = DailyReports.get_daily_report!(id)

    case DailyReports.update_daily_report(daily_report, daily_report_params) do
      {:ok, daily_report} ->
        conn
        |> put_flash(:info, "Daily report updated successfully.")
        |> redirect(to: Routes.daily_report_path(conn, :show, daily_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", daily_report: daily_report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    daily_report = DailyReports.get_daily_report!(id)
    {:ok, _daily_report} = DailyReports.delete_daily_report(daily_report)

    conn
    |> put_flash(:info, "Daily report deleted successfully.")
    |> redirect(to: Routes.daily_report_path(conn, :index))
  end

  defp get_user_groups(id), do: UserManager.get_user_groups(id)
end
