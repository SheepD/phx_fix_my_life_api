defmodule FixMyLifeWeb.ListController do
  use FixMyLifeWeb, :controller

  alias FixMyLife.Goals
  alias FixMyLife.Goals.List

  action_fallback FixMyLifeWeb.FallbackController

  def index(conn, _params) do
    lists = Goals.list_lists()
    render(conn, "index.json", lists: lists)
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, %List{} = list} <- Goals.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Goals.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Goals.get_list!(id)

    with {:ok, %List{} = list} <- Goals.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Goals.get_list!(id)
    with {:ok, %List{}} <- Goals.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
