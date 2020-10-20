defmodule TimeManagerWeb.WorkingTimesController do
  require Logger
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.WorkingTimes

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"userID" => user_id, "start" => start_time, "end" => end_time}) do
    workingtimes = Store.get_all_working_times_by_start_and_end_and_user_id!(user_id, start_time, end_time)
    Logger.info(workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => user_id, "working_times" => workingtimes}) do
    with {:ok, %WorkingTimes{} = working_times} <- Store.create_working_times_by_id(workingtimes) do
      Store.update_working_time(working_times, user_id)
      conn
      |> put_status(:created)
      |> render("show.json", working_times: working_times)
    end
  end

  def show(conn, %{"userID" => user_id, "workingTimeID" => working_times_id}) do
    Logger.info("NTM")
    working_time = Store.get_working_times!(working_times_id)
    render(conn, "show.json", working_times: working_time)
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
