defmodule TimeManagerWeb.WorkingTimesController do
  require Logger
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.WorkingTimes

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Store.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => user_id, "working_times" => workingtimes}) do
    working_times_obj = %{workingtimes | user_id: user_id}
    Logger.info(working_times_obj)
    with {:ok, %WorkingTimes{} = working_times} <- Store.create_working_times_by_id(working_times_obj) do
      conn
      |> put_status(:created)
      |> render("show.json", working_times: working_times)
    end
  end

  def show(conn, %{"id" => id}) do
    working_times = Store.get_working_times!(id)
    render(conn, "show.json", working_times: working_times)
  end

  def update(conn, %{"id" => id, "working_times" => working_times_params}) do
    working_times = Store.get_working_times!(id)

    with {:ok, %WorkingTimes{} = working_times} <- Store.update_working_times(working_times, working_times_params) do
      render(conn, "show.json", working_times: working_times)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_times = Store.get_working_times!(id)

    with {:ok, %WorkingTimes{}} <- Store.delete_working_times(working_times) do
      send_resp(conn, :no_content, "")
    end
  end
end
