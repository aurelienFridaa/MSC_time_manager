defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"userID" => user_id }) do
    clock = Store.get_clock_by_id!(user_id)
    render(conn, "index.json", clock: clock)
  end

  def create(conn, %{"userID" => user_id}) do
    with {:ok, %Clock{}} <- Store.create_clock_by_user_id(user_id) do
      conn
      |> put_status(:created)
    end
  end
end
