defmodule TimeManager.Store.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false, null: false
    field :time, :date, null: false
    belongs_to :user, TimeManager.Store.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:user_id])
  end
end
