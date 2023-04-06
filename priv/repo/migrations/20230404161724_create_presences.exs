defmodule YouboxApi.Repo.Migrations.CreatePresences do
  use Ecto.Migration

  def change do
    create table(:presences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :last_activity_at, :time
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:presences, [:user_id])
    create index(:presences, [:room_id])
  end
end
