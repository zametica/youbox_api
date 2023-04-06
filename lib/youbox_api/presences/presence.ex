defmodule YouboxApi.Presences.Presence do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "presences" do
    field :last_activity_at, :time
    field :status, :string
    field :user_id, :binary_id
    field :room_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(presence, attrs) do
    presence
    |> cast(attrs, [:status, :last_activity_at])
    |> validate_required([:status, :last_activity_at])
  end
end
