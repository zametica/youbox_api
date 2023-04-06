defmodule YouboxApiWeb.PresenceController do
  use YouboxApiWeb, :controller

  alias YouboxApi.Presences
  alias YouboxApi.Presences.Presence

  action_fallback YouboxApiWeb.FallbackController

  def index(conn, _params) do
    presences = Presences.list_presences()
    render(conn, :index, presences: presences)
  end

  def create(conn, %{"presence" => presence_params}) do
    with {:ok, %Presence{} = presence} <- Presences.create_presence(presence_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/presences/#{presence}")
      |> render(:show, presence: presence)
    end
  end

  def show(conn, %{"id" => id}) do
    presence = Presences.get_presence!(id)
    render(conn, :show, presence: presence)
  end

  def update(conn, %{"id" => id, "presence" => presence_params}) do
    presence = Presences.get_presence!(id)

    with {:ok, %Presence{} = presence} <- Presences.update_presence(presence, presence_params) do
      render(conn, :show, presence: presence)
    end
  end

  def delete(conn, %{"id" => id}) do
    presence = Presences.get_presence!(id)

    with {:ok, %Presence{}} <- Presences.delete_presence(presence) do
      send_resp(conn, :no_content, "")
    end
  end
end
