require_relative "../lib/ruby/team.rb"
require 'minitest/autorun'
require 'pry-rescue/minitest'

describe Team do
  it "has a name" do
    expect(Team.new("Team 1")).to respond_to :name
  end

  it "complains if the name is blank" do
    expect{ Team.new("") }.to raise_error
  end

  it "has a list of players"
  it "has a set order for turns for players"
  it "has a score"

end
