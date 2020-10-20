defmodule TimeManagerWeb.WorkingTimesController do
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.WorkingTimes

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Store.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"working_times" => working_times_params}) do
    with {:ok, %WorkingTimes{} = working_times} <- Store.create_working_times(working_times_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_times_path(conn, :show, working_times))
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
