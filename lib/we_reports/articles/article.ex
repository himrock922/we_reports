defmodule WeReports.Articles.Article do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    field :body, :string
    field :work_time, :string
    field :delete, :boolean, virtual: true
    field :tmp_id, :string, virtual: true
    belongs_to :daily_report, WeReports.DailyReports.DailyReport
    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> Map.put(:tmp_id, (article.tmp_id || attrs["tmp_id"]))
    |> cast(attrs, [:title, :body, :work_time, :delete])
    |> maybe_mark_for_deletion
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset
  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
