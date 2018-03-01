defmodule FixMyLife.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FixMyLife.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :token, :string
    field :token_expiration, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :token, :token_expiration])
    |> validate_required([:email, :name, :token, :token_expiration])
    |> unique_constraint(:email)
  end
end
