defmodule WeReportsWeb.DailyReports.New do
    use WeReportsWeb, :live_view
    use Phoenix.LiveView, layout: {WeReportsWeb.LayoutView, "live.html"}
    alias WeReports.Articles.Article
    alias WeReports.UserManager
    alias WeReports.DailyReports
    alias WeReports.Repo
    alias WeReports.DailyReports.DailyReport

    @impl true
    def mount(params, session, socket) do
      case UserManager.get_user_groups(String.to_integer(params["user"])) do
        user ->
          daily_report = %DailyReport{user_id: user.id, articles: []}
          changeset =
            DailyReports.change_daily_report(daily_report)
            |> Ecto.Changeset.put_assoc(:articles, daily_report.articles)
          {:ok, assign(socket, changeset: changeset, daily_report: daily_report, user: user)}
        _ ->
          {:noreply,
            socket
            |> put_flash(:error, "ユーザが見つかりませんでした")}
      end
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

    def handle_event("save", %{"daily_report" => params}, socket) do
      case DailyReports.create_daily_report(params) do
        {:ok, daily_report} ->
          {:noreply,
          socket
          |> put_flash(:success, "日報の作成に成功しました。")
          |> redirect(to: Routes.daily_report_path(socket, :show, daily_report))}
        _ ->
          {:noreply,
          socket
          |> put_flash(:error, "日報の作成に失敗しました。")}
      end
    end

    defp get_tmp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64 |> binary_part(0, 5)
  end
  