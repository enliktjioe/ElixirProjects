defmodule WikiDreamTest do
  use ExUnit.Case
  doctest WikiDream

  test "greets the world" do
    assert WikiDream.hello() == :world
  end
end
