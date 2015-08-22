require_relative './player'
require_relative './team'
require_relative './round'
require_relative '../services/round_store'

class Game
  include ActiveModel::Serialization

  attr_accessor :id, :attributes,
                :players, :current_player_ix, :lineup,
                :teams, :num_teams, :current_team, :scores,
                :clues, :current_round

  attr_reader :id, :current_round_count

  MIN_NUM_PLAYERS = 6
  CLUES_PER_PLAYER = 5

  def initialize
    @clues = []
    @current_player_ix = 0
    @current_round = nil
    @current_round_id = nil
    @current_round_count = nil
    @current_team = nil
    @id = SecureRandom.uuid
    @players = []
    @rounds = []
    @scores = nil
    @teams = []
    @attributes = nil
  end

  def start players, num_teams = 2
    @current_player_ix = 0
    @current_team = nil
    @players = create_players players
    @teams = create_teams num_teams
    start_round if can_start? # TODO fail gracefully
    @current_round = current_round
    @current_round_id = current_round_id
    @current_round_count = CelebrityApp.settings.round_store.find_all_by_game_id(@id).count
    @scores = scores
    @attributes = {
      "current_player" => @current_player,
      "current_round" => @current_round,
      "current_team" => @current_team,
      "teams" => @teams
    }
    self
  end

  def create_players players
    players.shuffle!
  end

  def add_clues clues
    @clues.concat(clues)
  end

  def create_teams num_teams
    players_per_team = (@players.length / num_teams).floor
    players_by_team = []
    @players.each_slice(players_per_team) do | group |
      players_by_team << group
    end
    teams = []
    num_teams.times do | i |
      players_by_team[i].each { | p | p.team = i }
      teams << Team.new("Team #{i}!", players_by_team[i])
    end
    teams
  end

  def current_player
    set_player_lineup if @lineup.nil?
    @lineup[@current_player_ix]
  end

  def next_player
    @lineup[@current_player_ix + 1] || @lineup[0];
  end

  def set_player_lineup
    @lineup = [];
    longest = @teams.map { | t | t.players.length }.max
    longest.times do | n |
      @teams.each do | t |
        @lineup << t.players[n] if t.players[n]
      end
    end
  end

  def scores
    @teams.map(&:score)
  end

  def current_team
    @teams.first
  end

  def current_round
    @rounds[@rounds.count - 1]
  end

  def current_round_id
    @rounds[@rounds.count - 1].id
  end

  def new_turn
    round = CelebrityApp.settings.round_store.find(current_round_id)
    @turn = round.new_turn
  end

  def start_round
    round = Round.new(@current_player_ix, @teams, @clues.dup, self)
    CelebrityApp.settings.round_store.add(round)
    @rounds << round
  end

  def can_start?
    # TODO throw specific errors
    has_teams? &&
    has_players? &&
    has_clues? &&
    sufficient_players? &&
    sufficient_clues?
  end

  def has_teams?
    @teams.length >= 2
  end

  def has_players?
    @players.all? { | p | p.name }
  end

  def has_clues?
    @clues.any?
  end

  def sufficient_players?
    @players.length >= MIN_NUM_PLAYERS
  end

  def sufficient_clues?
    @clues.length >= @players.length * CLUES_PER_PLAYER
  end
end
