defmodule FixMyLife.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :done, :boolean, default: false, null: false
      add :due, :time
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:list_id])
  end
end
