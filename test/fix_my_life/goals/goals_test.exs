defmodule FixMyLife.GoalsTest do
  use FixMyLife.DataCase

  alias FixMyLife.Goals

  describe "lists" do
    alias FixMyLife.Goals.List

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Goals.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Goals.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Goals.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Goals.create_list(@valid_attrs)
      assert list.name == "some name"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, list} = Goals.update_list(list, @update_attrs)
      assert %List{} = list
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_list(list, @invalid_attrs)
      assert list == Goals.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Goals.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Goals.change_list(list)
    end
  end

  describe "items" do
    alias FixMyLife.Goals.Item

    @valid_attrs %{done: true, due: ~T[14:00:00.000000], name: "some name"}
    @update_attrs %{done: false, due: ~T[15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{done: nil, due: nil, name: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Goals.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Goals.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Goals.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Goals.create_item(@valid_attrs)
      assert item.done == true
      assert item.due == ~T[14:00:00.000000]
      assert item.name == "some name"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Goals.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.done == false
      assert item.due == ~T[15:01:01.000000]
      assert item.name == "some updated name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_item(item, @invalid_attrs)
      assert item == Goals.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Goals.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Goals.change_item(item)
    end
  end
end
