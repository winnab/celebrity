require 'spec_helper'
require_relative "../../app/core/player"
require_relative "../../app/services/shuffler"

describe Shuffler do
  it "#shuffle_players" do
    alice = Player.new(1, 'Alice', [])
    bob = Player.new(1, 'Bob', [])
    carol = Player.new(1, 'Carol', [])
    players = [alice, bob, carol]

    shuffled_players = subject.shuffle_players(players)

    expect(shuffled_players).to_not be(players)
    expect(shuffled_players).to include(alice)
    expect(shuffled_players).to include(bob)
    expect(shuffled_players).to include(carol)
  end
end
