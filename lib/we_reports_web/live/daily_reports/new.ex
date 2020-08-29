defmodule WeReportsWeb.DailyReports.New do
    use WeReportsWeb, :live_view
    use Phoenix.LiveView, layout: {WeReportsWeb.LayoutView, "live.html"}
    alias WeReports.UserManager
    alias WeReports.Articles.Article
    alias WeReports.DailyReports.DailyReport
    alias WeReports.Repo
    require IEx

    @impl true
    def mount(params, session, socket) do
      case get_user(String.to_integer(params["user"])) do
        user ->
          daily_report =
            Ecto.build_assoc(user, :daily_reports)
            |> WeReports.DailyReports.DailyReport.changeset(%{})
          {:ok, assign(socket, current_user: user, daily_report: daily_report)}
        _ ->
          {:noreply,
            socket
            |> put_flash(:error, "user not found")}
      end
    end
  
    @impl true
    def handle_event("add_articles", params, socket) do
      IEx.pry
      if socket.assigns.daily_report.data.id == nil do
        daily_report = Repo.insert!(socket.assigns.daily_report)
        IEx.pry
        {:ok, assign(socket, current_user: socket.assigns.current_user, daily_report: daily_report)}
      else
        daily_report = Repo.update!(socket.assigns.daily_report)
        IEx.pry
        {:ok, assign(socket, current_user: socket.assigns.current_user, daily_report: daily_report)}
      end
    end

    defp get_user(id), do: UserManager.get_user!(id)

    defp get_user_groups(id), do: UserManager.get_user_groups(id)
  end
  