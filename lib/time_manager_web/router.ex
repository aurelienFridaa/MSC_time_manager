defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/workingtimes", WorkingTimesController, except: [:new, :edit]
    resources "/clocks/:userID", ClockController, except: [:delete, :update, :new, :edit, :show]

  end
end
