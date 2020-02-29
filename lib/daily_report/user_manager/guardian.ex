defmodule DailyReport.UserManager.Guardian do
  @moduledoc false
  use Guardian, otp_app: :daily_report
  alias DailyReport.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserManager.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def current_user(conn), do: Guardian.Plug.current_resource(conn, [])

  def logged_in?(conn), do: Guardian.Plug.authenticated?(conn, [])
end
