defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/clocks/:userID", ClockController, except: [:delete, :update, :new, :edit]

    post "/workingtimes/:userID", WorkingTimesController, :create
    put "/workingtimes/:id", WorkingTimesController, :update
    delete "/workingtimes/:id", WorkingTimesController, :delete
    get "/workingtimes/:userID/:workingTimeID", WorkingTimesController, :show


  end
end
