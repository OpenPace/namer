defmodule Namer.DescriptionGeneratorTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.DescriptionGenerator

  describe "generate_description/2" do
    test "with branding and no description" do
      user = build_user()
      assert DescriptionGenerator.generate_description(user, %{description: nil}) == "Renamed with openpace.co/namer"
    end

    test "with branding and an existing description" do
      user = build_user()
      description = DescriptionGenerator.generate_description(user, %{description: "Test"})
      assert description == "Test - Renamed with openpace.co/namer"
    end

    test "without branding and no description" do
      description = DescriptionGenerator.generate_description(%{}, %{description: nil})
      assert description == nil
    end

    test "without branding and an exisiting description" do
      description = DescriptionGenerator.generate_description(%{}, %{description: "Test"})
      assert description == "Test"
    end
  end

  defp build_user, do: %{user_prefs: %{branding: true}}
end
