require_relative "../../app/core/game"
require_relative "../../app/core/player"
require_relative "../../app/core/team"
require_relative "../../app/core/round"
require_relative "../../app/services/game_store"
require_relative "../../app/services/player_store"

require "spec_helper"

describe Game do
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
      clues = 5.times.map { | num | "#{name}-clue-#{num + 1}" }
      game_store.add_clues_to_game(@game.id, clues)
    end

    @game.start(player_store.find_all_by_game_id(@game.id), num_teams)
  end

  context "valid game" do
    let(:team) { @game.teams[0] }

    it "has an id" do
      expect(@game.id.length).to be > 10
    end

    it "has teams" do
      expect(team).to be_a(Team)
    end

    it "gives teams default scores of 0" do
      expect(team.score).to eql 0
    end

    it "evenly assigns players to teams" do
      team_sizes = @game.teams.collect { | t | t.players.length }
      min_size, max_size = team_sizes.minmax
      expect(max_size - min_size).to be <= 1
    end

    it "creates a collection of clues" do
      expect(@game.clues).to include("winna-clue-1")
    end

    it "sets the current player as a player instance" do
      expect(@game.current_player).to be_a(Player)
    end

    it "starts with a round that allows players to use as many words as they want" do
      expect(@game.current_round.type).to eql("UNLIMITED_WORDS")
    end
  end

  context "invalid game" do
    before do
      @game_store = GameStore.new
      @game_store.add(Game.new)
      @game = @game_store.list.last
      @num_teams = 2
      @player_store = PlayerStore.new
    end

    context "having fewer than 6 players" do
      it "cannot be started" do
        player_names = ["winna", "neil", "chucky"]

        player_names.each do |name|
          @player_store.add(Player.new(@game.id, name))
        end

        player_names.each do | name |
          5.times.each_with_object([]) do | i, obj |
            clues = obj << "#{name}-clue-#{i}"
            @game_store.add_clues_to_game(@game.id, clues)
          end
        end

        expect(@game.can_start?).to be false
      end
    end

    context "having an insufficient number of clues" do
      it "cannot start" do
        player_names = ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]

        player_names.each do |name|
          @player_store.add(Player.new(@game.id, name))
        end

        player_names.each do | name |
          1.times.each_with_object([]) do | i, obj |
            clues = obj << "#{name}-clue-#{i}"
            @game_store.add_clues_to_game(@game.id, clues)
          end
        end

        expect(@game.can_start?).to be false
      end
    end
  end
end
