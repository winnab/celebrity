require 'spec_helper'
require_relative "../../app/core/player"
require_relative "../../app/services/shuffler"

describe Shuffler do
  it "#shuffle_players" do
    alice = Player.new('Alice')
    bob = Player.new('Bob')
    carol = Player.new('Carol')
    players = [alice, bob, carol]

    shuffled_players = subject.shuffle_players(players)

    expect(shuffled_players).to_not be(players)
    expect(shuffled_players).to include(alice)
    expect(shuffled_players).to include(bob)
    expect(shuffled_players).to include(carol)
  end
end
