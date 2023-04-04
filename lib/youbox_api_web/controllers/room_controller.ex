defmodule YouboxApiWeb.RoomController do
  use YouboxApiWeb, :controller

  alias YouboxApi.Rooms
  alias YouboxApi.Rooms.Room

  action_fallback YouboxApiWeb.FallbackController

  # def index(conn, _params) do
  #   rooms = Rooms.list_rooms()
  #   render(conn, :index, rooms: rooms)
  # end

  def create(conn, %{"room" => room_params}) do
    user = Guardian.Plug.current_resource(conn)
    with {:ok, %Room{} = room} <- Rooms.create_room(Map.put(room_params, "created_by", user.id)) do
      conn
      |> put_status(:created)
      |> render(:show, room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    render(conn, :show, room: room)
  end
end
