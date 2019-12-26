defmodule Namer.UserPrefsFactory do
  @moduledoc false

  alias Namer.Accounts.UserPrefs

  defmacro __using__(_opts) do
    quote do
      def user_prefs_factory do
        %UserPrefs{
          branding: true,
          emoji: true,
          gender: Enum.random(0..3),
          imperial: true
        }
      end
    end
  end
end
