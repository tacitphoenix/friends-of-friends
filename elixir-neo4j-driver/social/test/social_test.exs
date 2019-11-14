defmodule SocialTest do
  use ExUnit.Case
  doctest Social

  test "insert friends" do
    result = Social.insert_friends()
    assert result.records == []
  end

  test "common friends" do
    result = Social.common_friends()
    assert result.records == [["Bob"]]
  end

  test "friends of a friend" do
    result = Social.friends_of_a_friend()
    assert result.records == [["Anna"]]
  end

  test "connecting paths" do
    result = Social.connecting_paths()
    [[nodes]] = result.records
    assert length(nodes) == 5
  end
end
