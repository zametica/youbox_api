defmodule YouboxApiWeb.Router do
  use YouboxApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", YouboxApiWeb do
    pipe_through :api
  end
end
