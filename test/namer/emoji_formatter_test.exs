defmodule Namer.EmojiFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.EmojiFormatter

  describe "format/1" do
    test "with emoji: true and female" do
      assert EmojiFormatter.format(%{type: "Run"}, emoji: true, gender: :female) == "🏃‍♀"
    end

    test "with emoji true, female, and no female emoji" do
      assert EmojiFormatter.format(%{type: "IceSkate"}, emoji: true, gender: :female) == "⛸️"
    end

    test "with emoji: true" do
      assert EmojiFormatter.format(%{type: "Run"}, emoji: true) == "🏃"
    end

    test "with emoji: false" do
      assert EmojiFormatter.format(%{type: "Run"}, emoji: false) == nil
    end
  end
end
