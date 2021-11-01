defmodule ElliTestTest do
  use ExUnit.Case
  doctest ElliTest

  test "greets the world" do
    assert ElliTest.hello() == :world
  end
end
