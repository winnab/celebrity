require_relative "../controllers/game"
require_relative "../controllers/player"
require_relative "../controllers/team"
require_relative "../controllers/round"
require_relative "../controllers/turn"
require "spec_helper"
require "pry"

describe Timer do
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

  let(:round) { game.current_round }
end
