require_relative './player'

class Game
  attr_accessor :players, :num_teams, :teams, :clues, :current_player_ix, :current_team, :current_round, :lineup
  attr_reader :id

  MIN_NUM_PLAYERS = 6

  def initialize players, num_teams = 2, start_game = true
    @num_teams = num_teams
    @players = players
    @id = SecureRandom.uuid
    start if start_game
  end

  def start
    @teams = create_teams num_teams
    @clues = collect_clues
    @current_player_ix = 0
    @current_team = nil
    @current_round = start_round
    @players = create_players @players # change constructor
  end

  def create_players players
    @players = []
    players.each { | p | @players << Player.new(p[:name], p[:clues]) }
    @players.shuffle!
    @players
  end

  def collect_clues
    @players.flat_map { | p | p.clues }
  end

  def create_teams num_teams
    players_per_team = (@players.length / num_teams).floor
    players_by_team = []
    @players.each_slice(players_per_team) do | group |
      players_by_team << group
    end
    @teams = []
    num_teams.times do | i |
      players_by_team[i].each { | p | p.team = i }
      teams << Team.new(i, players_by_team[i])
    end
    teams
  end

  def can_start?
    has_teams? && has_players? && has_clues? && sufficient_players? && sufficient_clues?
  end

  def has_teams?
    @teams.length >= 2
  end

  def has_players?
    @players.all? { | p | p.name }
  end

  def has_clues?
    @players.all? { | p | p.clues }
  end

  def sufficient_players?
    @players.length >= MIN_NUM_PLAYERS
  end

  def sufficient_clues?
    total = @players.reduce(0) { | ret, p | ret += p.clues.length }
    total >= ( @players.length * 4 )
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
  end

  def get_next_player

  end

  def start_round
    Round.new(@current_player_ix, @teams, @clues.dup, @game)
  end
end
