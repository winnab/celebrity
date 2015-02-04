require_relative "../app/core/game"
require_relative "../app/core/player"
require_relative "../app/core/team"
require_relative "../app/core/round"
require_relative "../app/core/turn"
require "spec_helper"

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
