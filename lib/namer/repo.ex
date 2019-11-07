defmodule Namer.Repo do
  use Ecto.Repo,
    otp_app: :namer,
    adapter: Ecto.Adapters.Postgres
end
