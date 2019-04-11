defmodule HayaseTest do
  use ExUnit.Case
  doctest Hayase

  test "greets the world" do
    assert Hayase.hello() == :world
  end
end
