defmodule TimeManagerWeb.WorkingTimesControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Store
  alias TimeManager.Store.WorkingTimes

  @create_attrs %{
    end: ~N[2010-04-17 14:00:00],
    start: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    end: ~N[2011-05-18 15:01:01],
    start: ~N[2011-05-18 15:01:01]
  }
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:working_times) do
    {:ok, working_times} = Store.create_working_times(@create_attrs)
    working_times
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, Routes.working_times_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create working_times" do
    test "renders working_times when data is valid", %{conn: conn} do
      conn = post(conn, Routes.working_times_path(conn, :create), working_times: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.working_times_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2010-04-17T14:00:00",
               "start" => "2010-04-17T14:00:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.working_times_path(conn, :create), working_times: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working_times" do
    setup [:create_working_times]

    test "renders working_times when data is valid", %{conn: conn, working_times: %WorkingTimes{id: id} = working_times} do
      conn = put(conn, Routes.working_times_path(conn, :update, working_times), working_times: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.working_times_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2011-05-18T15:01:01",
               "start" => "2011-05-18T15:01:01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, working_times: working_times} do
      conn = put(conn, Routes.working_times_path(conn, :update, working_times), working_times: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_times" do
    setup [:create_working_times]

    test "deletes chosen working_times", %{conn: conn, working_times: working_times} do
      conn = delete(conn, Routes.working_times_path(conn, :delete, working_times))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.working_times_path(conn, :show, working_times))
      end
    end
  end

  defp create_working_times(_) do
    working_times = fixture(:working_times)
    %{working_times: working_times}
  end
end
