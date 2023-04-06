defmodule YouboxApi.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `YouboxApi.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        content: %{}
      })
      |> YouboxApi.Events.create_event()

    event
  end
end
