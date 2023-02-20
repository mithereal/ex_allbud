defmodule AllbudTest do
  use ExUnit.Case
  doctest Allbud

  test "greets the world" do
    assert Allbud.hello() == :world
  end
end
