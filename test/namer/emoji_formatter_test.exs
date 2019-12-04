defmodule Namer.EmojiFormatterTest do
  use Namer.DataCase

  @moduledoc false

  alias Namer.EmojiFormatter

  test "format/1" do
    assert EmojiFormatter.format("Run") == "🏃"
  end
end
