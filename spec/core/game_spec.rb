require_relative "../../app/core/game"
require_relative "../../app/core/player"
require_relative "../../app/core/team"
require_relative "../../app/core/round"

require "spec_helper"

describe Game do
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

  let(:game) { Game.new(players_obj, num_teams) }

  context "valid game" do
    let(:team) { game.teams[0] }

    it "has teams" do
      expect(team).to be_a(Team)
    end

    it "gives teams default scores of 0" do
      expect(team.score).to eql 0
    end

    it "evenly assigns players to teams" do
      team_sizes = game.teams.collect { | t | t.players.length }
      min_size, max_size = team_sizes.minmax
      expect(max_size - min_size).to be <= 1
    end

    it "creates a collection of clues" do
      expect(game.clues).to include("winna-clue-1")
    end

    it "sets the current player as a player instance" do
      expect(game.current_player).to be_a(Player)
    end

    it "starts with a round that allows players to use as many words as they want" do
      expect(game.current_round.type).to eql("UNLIMITED_WORDS")
    end
  end

  context "invalid game" do
    context "having fewer than 6 players" do
      let(:game) { Game.new(players_obj[0, 4], num_teams) }
      it "cannot be started" do
        expect(game.can_start?).to be false
      end
    end
    context "having an insufficient number of clues" do
      let(:players_obj) {
        players.map do | p |
          {
            name: p,
            clues: 3.times.each_with_object([]) { | i, obj | obj << "clue-#{i}" }
          }
        end
       }

      it "cannot start" do
        expect(game.can_start?).to be false
      end
    end
  end
end
