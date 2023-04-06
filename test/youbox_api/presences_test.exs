defmodule YouboxApi.PresencesTest do
  use YouboxApi.DataCase

  alias YouboxApi.Presences

  describe "presences" do
    alias YouboxApi.Presences.Presence

    import YouboxApi.PresencesFixtures

    @invalid_attrs %{last_activity_at: nil, status: nil}

    test "list_presences/0 returns all presences" do
      presence = presence_fixture()
      assert Presences.list_presences() == [presence]
    end

    test "get_presence!/1 returns the presence with given id" do
      presence = presence_fixture()
      assert Presences.get_presence!(presence.id) == presence
    end

    test "create_presence/1 with valid data creates a presence" do
      valid_attrs = %{last_activity_at: ~T[14:00:00], status: "some status"}

      assert {:ok, %Presence{} = presence} = Presences.create_presence(valid_attrs)
      assert presence.last_activity_at == ~T[14:00:00]
      assert presence.status == "some status"
    end

    test "create_presence/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Presences.create_presence(@invalid_attrs)
    end

    test "update_presence/2 with valid data updates the presence" do
      presence = presence_fixture()
      update_attrs = %{last_activity_at: ~T[15:01:01], status: "some updated status"}

      assert {:ok, %Presence{} = presence} = Presences.update_presence(presence, update_attrs)
      assert presence.last_activity_at == ~T[15:01:01]
      assert presence.status == "some updated status"
    end

    test "update_presence/2 with invalid data returns error changeset" do
      presence = presence_fixture()
      assert {:error, %Ecto.Changeset{}} = Presences.update_presence(presence, @invalid_attrs)
      assert presence == Presences.get_presence!(presence.id)
    end

    test "delete_presence/1 deletes the presence" do
      presence = presence_fixture()
      assert {:ok, %Presence{}} = Presences.delete_presence(presence)
      assert_raise Ecto.NoResultsError, fn -> Presences.get_presence!(presence.id) end
    end

    test "change_presence/1 returns a presence changeset" do
      presence = presence_fixture()
      assert %Ecto.Changeset{} = Presences.change_presence(presence)
    end
  end
end
