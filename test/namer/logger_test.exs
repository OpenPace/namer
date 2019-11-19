defmodule Namer.LoggerTest do
  use Namer.DataCase

  alias Namer.Logger

  describe "webhook_events" do
    alias Namer.Logger.WebhookEvent

    test "log_webhook_event/1 creates a webhook_event" do
      attrs = %{body: "body", provider: "strava"}
      assert {:ok, %WebhookEvent{} = webhook_event} = Logger.log_webhook_event(attrs)
      assert webhook_event.body == "body"
      assert webhook_event.provider == "strava"
    end
  end
end
