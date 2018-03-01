defmodule FixMyLifeWeb.ItemControllerTest do
  use FixMyLifeWeb.ConnCase

  alias FixMyLife.Goals
  alias FixMyLife.Goals.Item

  @create_attrs %{done: true, due: ~T[14:00:00.000000], name: "some name"}
  @update_attrs %{done: false, due: ~T[15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{done: nil, due: nil, name: nil}

  def fixture(:item) do
    {:ok, item} = Goals.create_item(@create_attrs)
    item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get conn, item_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post conn, item_path(conn, :create), item: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, item_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "done" => true,
        "due" => ~T[14:00:00.000000],
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, item_path(conn, :create), item: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put conn, item_path(conn, :update, item), item: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, item_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "done" => false,
        "due" => ~T[15:01:01.000000],
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put conn, item_path(conn, :update, item), item: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete conn, item_path(conn, :delete, item)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, item_path(conn, :show, item)
      end
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    {:ok, item: item}
  end
end
