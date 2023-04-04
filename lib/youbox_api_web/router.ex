defmodule YouboxApiWeb.Router do
  use YouboxApiWeb, :router
  use Plug.ErrorHandler

  # defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  #   conn |> json(%{errors: message}) |> halt()
  # end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug YouboxApiWeb.Auth.Pipeline
  end

  scope "/api", YouboxApiWeb do
    pipe_through :api

    post "/sign_in", UserController, :sign_in
    post "/sign_up", UserController, :create
  end

  scope "/api", YouboxApiWeb do
    pipe_through [:api, :auth]

    resources "/rooms", RoomController, only: [:create, :show]
  end
end
