defmodule Namer.Reporter do
  @moduledoc """
  This module reports information to slack
  """

  alias Namer.Accounts.User
  alias Slack.Web.Chat

  def report_new_user(%User{strava_uid: uid}) do
    text = "New User Created: #{uid} https://www.strava.com/athletes/#{uid}"
    Chat.post_message("#namer", text)
  end
end
