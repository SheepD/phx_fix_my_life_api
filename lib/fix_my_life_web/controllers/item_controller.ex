defmodule FixMyLifeWeb.ItemController do
  use FixMyLifeWeb, :controller

  alias FixMyLife.Goals
  alias FixMyLife.Goals.Item

  action_fallback FixMyLifeWeb.FallbackController

  def index(conn, _params) do
    items = Goals.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Goals.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", list_item_path(conn, :show, item))
      |> render("show.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Goals.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Goals.get_item!(id)

    with {:ok, %Item{} = item} <- Goals.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Goals.get_item!(id)
    with {:ok, %Item{}} <- Goals.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
