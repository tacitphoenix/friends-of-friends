require "./spec_helper"

describe "Social::Graph" do

  it "inserts friends" do
    sg = Social::Graph.new
    res = sg.insert_friends
    res.data.should eq([] of String)
  end

  it "friends of a friend" do
    sg = Social::Graph.new
    res = sg.friends_of_a_friend
    res.data.should eq([["Anna"]])
  end

  it "common friends" do
    sg = Social::Graph.new
    res = sg.common_friends
    res.data.should eq([["Bob"]])
  end

  it "connecting paths" do
    sg = Social::Graph.new
    res = sg.connecting_paths
    count = res.data[0].size
    count.should eq(1)
  end
end
