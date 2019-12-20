defmodule Namer.EmojiFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.EmojiFormatter

  test "format/1 with emoji: true" do
    assert EmojiFormatter.format(%{type: "Run"}, emoji: true) == "🏃"
  end

  test "format/1 with emoji: false" do
    assert EmojiFormatter.format(%{type: "Run"}, emoji: false) == nil
  end
end
