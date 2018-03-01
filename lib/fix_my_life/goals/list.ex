defmodule FixMyLife.Goals.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias FixMyLife.Goals.List


  schema "lists" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%List{} = list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
