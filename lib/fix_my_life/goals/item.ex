defmodule FixMyLife.Goals.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias FixMyLife.Goals.Item


  schema "items" do
    field :done, :boolean, default: false
    field :due, :time
    field :name, :string
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:name, :done, :due])
    |> validate_required([:name, :done, :due])
  end
end
