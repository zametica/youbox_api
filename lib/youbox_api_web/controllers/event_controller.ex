defmodule YouboxApiWeb.EventController do
  use YouboxApiWeb, :controller

  alias YouboxApi.Events

  action_fallback YouboxApiWeb.FallbackController

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, :index, events: events)
  end
end
