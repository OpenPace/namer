defmodule Mix.Tasks.User.Delete do
  use Mix.Task

  @moduledoc """
  Deletes a user by id

  ## Examples

  cmd> mix user.delete 1
  User 1 deleted

  cmd> mix user.delete
  No user id provided
  """

  alias Namer.Accounts

  def run([user_id]) do
    Mix.Task.run("app.start")
    user = Accounts.get_user!(user_id)
    Accounts.delete_user(user)
    Mix.shell.info("User #{user_id} deleted")
  end

  def run(_), do: Mix.shell().error("No user id provided")
end
