defmodule Mix.Tasks.User.SetPremium do
  use Mix.Task

  @moduledoc """
  Runs through all users and figures out if the user is strava premium

  ## Examples

  cmd> mix users.set_premium
  """

  alias Namer.Accounts
  alias Namer.Accounts.User
  alias Namer.Repo
  alias Strava.{Athletes, Client}

  def run(_) do
    Mix.Task.run("app.start")

    User
    |> Repo.all()
    |> Enum.each(fn (user) ->
      client = Client.new(user.access_token,
        refresh_token: user.refresh_token,
        token_refreshed: &Accounts.update_user(user, Map.from_struct(&1.token))
      )

      {:ok, athlete} = Athletes.get_logged_in_athlete(client)
      Accounts.update_user(user, %{premium: athlete.premium})
      Mix.shell.info("User #{user.id} updated")
    end)
  end
end
