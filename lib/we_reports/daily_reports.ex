defmodule WeReports.DailyReports do
  @moduledoc """
  The DailyReports context.
  """

  import Ecto.Query, warn: false
  alias WeReports.Repo

  alias WeReports.{Articles.Article, Articles, DailyReports.DailyReport}
  @doc """
  Returns the list of daily_reports.

  ## Examples

      iex> list_daily_reports()
      [%DailyReport{}, ...]

  """
  def list_daily_reports, do: Repo.all(DailyReport) |> Repo.preload(:user)

  def list_daily_reports(user_id) do
    Repo.all(from d in DailyReport, where: d.user_id == ^user_id)
  end
  @doc """
  Gets a single daily_report.

  Raises `Ecto.NoResultsError` if the Daily report does not exist.

  ## Examples

      iex> get_daily_report!(123)
      %DailyReport{}

      iex> get_daily_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_report!(id), do: Repo.get!(DailyReport, id) |> Repo.preload(:articles)

  @doc """
  Creates a daily_report.

  ## Examples

      iex> create_daily_report(%{field: value})
      {:ok, %DailyReport{}}

      iex> create_daily_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_report(attrs \\ %{}) do
    %DailyReport{}
    |> DailyReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_report.

  ## Examples

      iex> update_daily_report(daily_report, %{field: new_value})
      {:ok, %DailyReport{}}

      iex> update_daily_report(daily_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_report(%DailyReport{} = daily_report, attrs) do
    daily_report
    |> DailyReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DailyReport.

  ## Examples

      iex> delete_daily_report(daily_report)
      {:ok, %DailyReport{}}

      iex> delete_daily_report(daily_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_report(%DailyReport{} = daily_report) do
    Repo.delete(daily_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_report changes.

  ## Examples

      iex> change_daily_report(daily_report)
      %Ecto.Changeset{source: %DailyReport{}}

  """
  def change_daily_report(%DailyReport{} = daily_report) do
    DailyReport.changeset(daily_report, %{})
  end

  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end

end
