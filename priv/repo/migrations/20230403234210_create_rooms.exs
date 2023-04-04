defmodule YouboxApi.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :created_by, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:rooms, [:created_by])
  end
end
