defmodule YouboxApiWeb.EventJSON do
  alias YouboxApi.Events.Event

  @doc """
  Renders a list of events.
  """
  def index(%{events: events}) do
    %{data: for(event <- events, do: data(event))}
  end

  @doc """
  Renders a single event.
  """
  def show(%{event: event}) do
    %{data: data(event)}
  end

  defp data(%Event{} = event) do
    %{
      id: event.id,
      content: event.content
    }
  end
end
