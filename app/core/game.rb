require_relative './player'
require_relative './team'
require_relative './round'

class Game
  attr_accessor :players, :num_teams, :teams, :clues, :current_player_ix, :current_team, :current_round, :lineup, :id
  attr_reader :id, :current_round_count

  MIN_NUM_PLAYERS = 6
  CLUES_PER_PLAYER = 5

  def initialize
    @id = SecureRandom.uuid
    @rounds = []
    @clues = []
  end

  def start players, num_teams = 2
    @current_player_ix = 0
    @current_team = nil
    @players = create_players players
    @teams = create_teams num_teams
    start_round if can_start? # TODO fail gracefully
    @current_round = current_round
    @current_round_count = @rounds.count
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

  def current_team
    @teams.first
  end

  def current_round
    @rounds[@rounds.count - 1]
  end

  def new_turn
    round = current_round
    @turn = round.new_turn
  end

  def start_round
    @rounds << Round.new(@current_player_ix, @teams, @clues.dup, @game)
  end

  def can_start?
    has_teams? && has_players? && has_clues? && sufficient_players? && sufficient_clues? # TODO throw specific errors
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
