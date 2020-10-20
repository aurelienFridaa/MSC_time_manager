defmodule TimeManager.Store.WorkingTimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :utc_datetime, null: false
    field :start, :utc_datetime, null: false
    field :user_id, :id, null: false, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(working_times, attrs) do
    working_times
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
