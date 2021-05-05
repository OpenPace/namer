defmodule Namer.UserFactory do
  @moduledoc false

  alias Faker.{Avatar, Name, UUID}
  alias Namer.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          name: Name.name(),
          avatar: Avatar.image_url(),
          premium: true,
          strava_uid: sequence(:external_id, &("#{&1}")),
          access_token: UUID.v4(),
          refresh_token: UUID.v4(),
          user_prefs: build(:user_prefs)
        }
      end
    end
  end
end
