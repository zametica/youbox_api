defmodule YouboxApi.Events.Event do
  alias YouboxApi.Users
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, except: [:__meta__, :user, :room]}
  schema "events" do
    field :content, :map
    field :type, Ecto.Enum, values: [:playlist, :message]
    belongs_to :user, Users.User
    belongs_to :room, Rooms.Room

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:content, :type, :user_id, :room_id])
    |> validate_required([:content, :type])
  end
end
