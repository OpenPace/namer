defmodule Namer.AccountsTest do
  use Namer.DataCase

  alias Namer.Accounts

  describe "users" do
    alias Namer.Accounts.User

    @valid_attrs %{access_token: "some access_token", avatar: "some avatar", name: "some name", refresh_token: "some refresh_token", strava_uid: "some strava_uid"}
    @update_attrs %{access_token: "some updated access_token", avatar: "some updated avatar", name: "some updated name", refresh_token: "some updated refresh_token", strava_uid: "some updated strava_uid"}
    @invalid_attrs %{access_token: nil, avatar: nil, name: nil, refresh_token: nil, strava_uid: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.access_token == "some access_token"
      assert user.avatar == "some avatar"
      assert user.name == "some name"
      assert user.refresh_token == "some refresh_token"
      assert user.strava_uid == "some strava_uid"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.access_token == "some updated access_token"
      assert user.avatar == "some updated avatar"
      assert user.name == "some updated name"
      assert user.refresh_token == "some updated refresh_token"
      assert user.strava_uid == "some updated strava_uid"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
