require "minitest/autorun"
require "./social"

class TestSocial < Minitest::Test
    def test_insert_friends
        sg = Social::Graph.new
        result = sg.insert_friends()
        assert_equal result.rows, []
    end

    def test_common_friends
        sg = Social::Graph.new
        result = sg.common_friends()
        assert_equal result, ["Bob"]
    end

    def test_friends_of_a_friend
        sg = Social::Graph.new
        result = sg.friends_of_a_friend()
        assert_equal result, ["Anna"]
    end

    def test_connecting_paths
        sg = Social::Graph.new
        result = sg.connecting_paths()
        assert_equal result, ["Joe", "Sally", "Anna", "Jim", "Billy"]
    end
end