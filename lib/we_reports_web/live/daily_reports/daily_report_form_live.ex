defmodule WeReportsWeb.DailyReportFormLive do
  @moduledoc false
  use Phoenix.LiveView
  alias WeReports.Repo
  alias WeReports.{Articles.Article, DailyReports, DailyReports.DailyReport, UserManager}

  @impl true
  def mount(params, session, socket) do
    case UserManager.get_user_groups(session["current_user_id"]) do
      user ->
        daily_report = get_daily_report(session, user)
        changeset =
          DailyReports.change_daily_report(daily_report)
          |> Ecto.Changeset.put_assoc(:articles, daily_report.articles)
        assigns = [
          action: session["action"],
          csrf_token: session["csrf_token"],
          changeset: changeset,
          daily_report: daily_report,
          user: user
        ]
        {:ok, assign(socket, assigns)}
    end
  end

  def render(assigns) do
    WeReportsWeb.DailyReportView.render("form.html", assigns)
  end

  @impl true
  def handle_event("add_article", _params, socket) do
    existing_articles = Map.get(socket.assigns.changeset.changes, :articles, socket.assigns.daily_report.articles)
    articles =
      existing_articles
      |> Enum.concat([
        DailyReports.change_article(%Article{tmp_id: get_tmp_id()})
      ])
    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:articles, articles)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove-article", %{"remove" => remove_id}, socket) do
    articles =
      socket.assigns.changeset.changes.articles
      |> Enum.reject(fn %{data: article} ->
        article.tmp_id == remove_id
      end)
    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:articles, articles)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"daily_report" => params}, socket) do
    changeset =
    socket.assigns.daily_report
    |> DailyReport.changeset(params)
    |> Map.put(:action, :insert)
    {:noreply, assign(socket, changeset: changeset)}
  end

  defp get_daily_report(%{"id" => id} = _daily_report_params, user), do: DailyReports.get_daily_report!(id)
  defp get_daily_report(_daily_report_params, user), do: %DailyReport{user_id: user.id, articles: []}
  defp get_tmp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64 |> binary_part(0, 5)
end
