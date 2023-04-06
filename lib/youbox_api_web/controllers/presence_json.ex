defmodule YouboxApiWeb.PresenceJSON do
  alias YouboxApi.Presences.Presence

  @doc """
  Renders a list of presences.
  """
  def index(%{presences: presences}) do
    %{data: for(presence <- presences, do: data(presence))}
  end

  @doc """
  Renders a single presence.
  """
  def show(%{presence: presence}) do
    %{data: data(presence)}
  end

  defp data(%Presence{} = presence) do
    %{
      id: presence.id,
      status: presence.status,
      last_activity_at: presence.last_activity_at
    }
  end
end
