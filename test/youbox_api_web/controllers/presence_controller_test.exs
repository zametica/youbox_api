defmodule YouboxApiWeb.PresenceControllerTest do
  use YouboxApiWeb.ConnCase

  import YouboxApi.PresencesFixtures

  alias YouboxApi.Presences.Presence

  @create_attrs %{
    last_activity_at: ~T[14:00:00],
    status: "some status"
  }
  @update_attrs %{
    last_activity_at: ~T[15:01:01],
    status: "some updated status"
  }
  @invalid_attrs %{last_activity_at: nil, status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all presences", %{conn: conn} do
      conn = get(conn, ~p"/api/presences")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create presence" do
    test "renders presence when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/presences", presence: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/presences/#{id}")

      assert %{
               "id" => ^id,
               "last_activity_at" => "14:00:00",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/presences", presence: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update presence" do
    setup [:create_presence]

    test "renders presence when data is valid", %{conn: conn, presence: %Presence{id: id} = presence} do
      conn = put(conn, ~p"/api/presences/#{presence}", presence: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/presences/#{id}")

      assert %{
               "id" => ^id,
               "last_activity_at" => "15:01:01",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, presence: presence} do
      conn = put(conn, ~p"/api/presences/#{presence}", presence: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete presence" do
    setup [:create_presence]

    test "deletes chosen presence", %{conn: conn, presence: presence} do
      conn = delete(conn, ~p"/api/presences/#{presence}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/presences/#{presence}")
      end
    end
  end

  defp create_presence(_) do
    presence = presence_fixture()
    %{presence: presence}
  end
end
