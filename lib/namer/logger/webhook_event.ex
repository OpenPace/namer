defmodule Namer.Logger.WebhookEvent do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  This module contains the schema for logging webhook events.
  """

  schema "webhook_events" do
    field :body, :string
    field :provider, :string

    timestamps()
  end

  @doc false
  def changeset(webhook_event, attrs) do
    webhook_event
    |> cast(attrs, [:provider, :body])
  end
end
