require IEx

defmodule YouboxApiWeb.RoomChannel do
  use YouboxApiWeb, :channel
  alias YouboxApi.Events
  alias YouboxApi.Events.Event

  @impl true
  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      {:ok, assign(socket, room_id: room_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("playlist_add", payload, socket) do
    create_event(:playlist, payload, socket)
  end

  @impl true
  def handle_in("playlist_remove", payload, socket) do
    remove_event(:playlist, payload, socket)
  end

  @impl true
  def handle_in("message_add", payload, socket) do
    create_event(:message, payload, socket)
  end

  defp create_event(type, payload, socket) do
    with {:ok, %Event{} = event} <- Events.create_event(
      %{
        content: %{ slug: payload["slug"] },
        type: type,
        room_id: socket.assigns[:room_id],
        user_id: socket.assigns[:user_id]
      }
    ) do
      broadcast(socket, "#{type}_add", event)
      {:noreply, socket}
    else
      _ -> {:error, %{reason: "failed"}}
    end
  end

  defp remove_event(type, payload, socket) do
    Events.delete_by_id(payload["event_id"])
    broadcast(socket, "#{type}_remove", %{id: payload["event_id"]})
    {:noreply, socket}
  end

  defp authorized?(payload) do
    case YouboxApiWeb.Auth.Guardian.decode_and_verify(payload["token"], %{}) do
      {:ok, _claims} -> true
      _ -> false
    end
  end
end
