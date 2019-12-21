defmodule Namer.Reporter do
  @moduledoc """
  This module reports information to slack
  """

  alias Namer.Accounts.User
  alias Slack.Web.Chat

  def report_new_user(%User{name: name}) do
    text = "New User Created: #{name}"
    Chat.post_message("#namer", text)
  end
end
