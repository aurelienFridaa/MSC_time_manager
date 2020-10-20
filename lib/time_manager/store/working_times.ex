defmodule TimeManager.Store.WorkingTimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime, null: false
    field :start, :naive_datetime, null: false
    field :user_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(working_times, attrs) do
    working_times
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
