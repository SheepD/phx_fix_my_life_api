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
end
