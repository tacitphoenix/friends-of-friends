defmodule SocialTest do
  use ExUnit.Case
  doctest Social

  test "greets the world" do
    assert Social.hello() == :world
  end
end
