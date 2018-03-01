defmodule FixMyLifeWeb.ItemView do
  use FixMyLifeWeb, :view
  alias FixMyLifeWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      name: item.name,
      done: item.done,
      due: item.due}
  end
end
