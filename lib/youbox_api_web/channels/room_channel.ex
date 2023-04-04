require IEx

defmodule YouboxApiWeb.RoomChannel do
  use YouboxApiWeb, :channel

  @impl true
  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      {:ok, assign(socket, room_id: room_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("message", payload, socket) do
    broadcast(socket, "message", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(payload) do
    case YouboxApiWeb.Auth.Guardian.decode_and_verify(payload["token"], %{}) do
      {:ok, _claims} -> true
      _ -> false
    end
  end
end
