require_relative "../../app/core/game"
require_relative "../../app/core/player"
require_relative "../../app/core/team"
require_relative "../../app/core/round"
require_relative "../../app/core/turn"
require "spec_helper"

describe Round do
  let(:players) {
    ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]
  }

  let(:players_obj) {
    players.map do | p |
      {
        name: p,
        clues: 5.times.each_with_object([]) { | i, obj | obj << "#{p}-clue-#{i}" }
      }
    end
   }

  let(:num_teams) { 2 }

  let(:game) { Game.new(players_obj.first).start(players_obj, num_teams) }

  let(:round) { game.current_round }

  it "#new_turn" do
    expect(round.new_turn).to be_a(Turn)
  end

  describe "#next_player" do
    before(:each) { game.set_player_lineup }

    it "picks the next player in the lineup" do
      expect(game.next_player).to_not be(game.current_player)
      expect(game.next_player).to be(game.lineup[1])
    end

    it "loops back to the start of the lineup when needed" do
      game.current_player_ix = game.lineup.length - 1
      expect(game.next_player).to be(game.lineup[0])
    end
  end

  # it "knows the round number"
  # it "knows how many clues have been guessed this round"
  # it "knows how many clues remain this round"
  # it "increment or decrement a team's score"
end
