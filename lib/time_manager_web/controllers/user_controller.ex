defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username }) do
    user = Store.get_user_by_email_and_username!(email, username)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Store.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Store.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Store.get_user!(id)

    with {:ok, %User{} = user} <- Store.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Store.get_user!(id)

    with {:ok, %User{}} <- Store.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
