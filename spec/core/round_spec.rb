require_relative "../../app/core/game"
require_relative "../../app/core/player"
require_relative "../../app/core/team"
require_relative "../../app/core/round"
require_relative "../../app/core/turn"
require_relative "../../app/services/game_store"
require_relative "../../app/services/player_store"

require "spec_helper"

describe Round do
  before do
    game_store = GameStore.new
    game_store.add(Game.new)
    @game = game_store.list.last
    num_teams = 2

    player_store = PlayerStore.new
    player_names = ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]

    player_names.each do |name|
      player_store.add(Player.new(@game.id, name))
    end

    player_names.each do | name |
      5.times.each_with_object([]) do | i, obj |
        clues = obj << "#{name}-clue-#{i}"
        game_store.add_clues_to_game(@game.id, clues)
      end
    end

    @game.start(player_store.find_all_by_game_id(@game.id), num_teams)
  end

  it "#new_turn" do
    expect(@game.current_round.new_turn).to be_a(Turn)
  end

  describe "#next_player" do
    before(:each) { @game.set_player_lineup }

    it "picks the next player in the lineup" do
      expect(@game.next_player).to_not be(@game.current_player)
      expect(@game.next_player).to be(@game.lineup[1])
    end

    it "loops back to the start of the lineup when needed" do
      @game.current_player_ix = @game.lineup.length - 1
      expect(@game.next_player).to be(@game.lineup[0])
    end
  end

  # it "knows the round number"
  # it "knows how many clues have been guessed this round"
  # it "knows how many clues remain this round"
  # it "increment or decrement a team's score"
end
