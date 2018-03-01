defmodule FixMyLife.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :token, :string
      add :token_expiration, :utc_datetime

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
