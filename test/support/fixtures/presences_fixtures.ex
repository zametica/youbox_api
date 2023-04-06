defmodule YouboxApi.PresencesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `YouboxApi.Presences` context.
  """

  @doc """
  Generate a presence.
  """
  def presence_fixture(attrs \\ %{}) do
    {:ok, presence} =
      attrs
      |> Enum.into(%{
        last_activity_at: ~T[14:00:00],
        status: "some status"
      })
      |> YouboxApi.Presences.create_presence()

    presence
  end
end
