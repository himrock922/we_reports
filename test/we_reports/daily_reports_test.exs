defmodule WeReports.DailyReportsTest do
  use WeReports.DataCase

  alias WeReports.DailyReports

  describe "daily_reports" do
    alias WeReports.DailyReports.DailyReport

    @valid_attrs %{next_action: "some next_action", summary: "some summary"}
    @update_attrs %{next_action: "some updated next_action", summary: "some updated summary"}
    @invalid_attrs %{next_action: nil, summary: nil}

    def daily_report_fixture(attrs \\ %{}) do
      {:ok, daily_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DailyReports.create_daily_report()

      daily_report
    end

    test "list_daily_reports/0 returns all daily_reports" do
      daily_report = daily_report_fixture()
      assert DailyReports.list_daily_reports() == [daily_report]
    end

    test "get_daily_report!/1 returns the daily_report with given id" do
      daily_report = daily_report_fixture()
      assert DailyReports.get_daily_report!(daily_report.id) == daily_report
    end

    test "create_daily_report/1 with valid data creates a daily_report" do
      assert {:ok, %DailyReport{} = daily_report} = DailyReports.create_daily_report(@valid_attrs)
      assert daily_report.next_action == "some next_action"
      assert daily_report.summary == "some summary"
    end

    test "create_daily_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DailyReports.create_daily_report(@invalid_attrs)
    end

    test "update_daily_report/2 with valid data updates the daily_report" do
      daily_report = daily_report_fixture()
      assert {:ok, %DailyReport{} = daily_report} = DailyReports.update_daily_report(daily_report, @update_attrs)
      assert daily_report.next_action == "some updated next_action"
      assert daily_report.summary == "some updated summary"
    end

    test "update_daily_report/2 with invalid data returns error changeset" do
      daily_report = daily_report_fixture()
      assert {:error, %Ecto.Changeset{}} = DailyReports.update_daily_report(daily_report, @invalid_attrs)
      assert daily_report == DailyReports.get_daily_report!(daily_report.id)
    end

    test "delete_daily_report/1 deletes the daily_report" do
      daily_report = daily_report_fixture()
      assert {:ok, %DailyReport{}} = DailyReports.delete_daily_report(daily_report)
      assert_raise Ecto.NoResultsError, fn -> DailyReports.get_daily_report!(daily_report.id) end
    end

    test "change_daily_report/1 returns a daily_report changeset" do
      daily_report = daily_report_fixture()
      assert %Ecto.Changeset{} = DailyReports.change_daily_report(daily_report)
    end
  end

end
