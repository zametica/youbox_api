defmodule YouboxApiWeb.UserController do
  use YouboxApiWeb, :controller

  alias YouboxApiWeb.Auth.ErrorResponse.Unauthorized
  alias YouboxApiWeb.Auth.Guardian
  alias YouboxApi.Users
  alias YouboxApi.Users.User

  action_fallback YouboxApiWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render(:access_token, token: token)
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, _user, token} ->
        conn
        |> put_status(:ok)
        |> render(:access_token, token: token)
      {:error, :unauthorized} ->
        raise Unauthorized
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
