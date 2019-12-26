defmodule Namer.Factory do
  use ExMachina.Ecto, repo: Namer.Repo

  use Namer.UserFactory
  use Namer.UserPrefsFactory

  @moduledoc false
end
