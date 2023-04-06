defmodule YouboxApiWeb.UserJSON do
  alias YouboxApi.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def access_token(%{token: token, user: user}) do
    %{
      access_token: token,
      user_id: user.id
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      hash_password: user.hash_password
    }
  end
end
