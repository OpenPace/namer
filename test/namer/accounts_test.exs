defmodule Namer.AccountsTest do
  use Namer.DataCase

  alias Namer.Accounts

  import Namer.Factory

  describe "get_user_by_uid/1" do
    setup [:create_user]

    test "works with integer" do
      assert user = Accounts.get_user_by_uid(1234)
      assert user.id != nil
      assert user.strava_uid == "1234"
    end

    test "works with string" do
      assert user = Accounts.get_user_by_uid("1234")
      assert user.id != nil
      assert user.strava_uid == "1234"
    end
  end

  defp create_user(_) do
    {:ok, user: insert(:user, strava_uid: "1234")}
  end
end
