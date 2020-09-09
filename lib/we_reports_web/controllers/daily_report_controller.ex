defmodule WeReportsWeb.DailyReportController do
  use WeReportsWeb, :controller

  alias WeReports.DailyReports
  alias WeReports.DailyReports.DailyReport
  alias WeReports.UserManager.Guardian

  def index(conn, _params) do
    user = Guardian.current_user(conn)
    daily_reports = DailyReports.list_daily_reports
    render(conn, "index.html", daily_reports: daily_reports, user: user)
  end

  def new(conn, _params) do
    changeset = DailyReports.change_daily_report(%DailyReport{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"daily_report" => daily_report_params}) do
    case DailyReports.create_daily_report(daily_report_params) do
      {:ok, daily_report} ->
        conn
        |> put_flash(:success, "日報の作成に成功しました。")
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
        |> put_flash(:success, "日報の更新に成功しました。")
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

end
