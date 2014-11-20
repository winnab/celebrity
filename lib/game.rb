require 'observer'

module Celebrity
  class Invite
    attr_accessor :sender, :recipients

    def initialize sender, recipients
      @sender = sender
      @recipients = recipients
    end

    def has_sender?
      !(@sender[:name].empty? && @sender[:email].empty?)
    end

    def has_recipient_emails?
      @recipients.all? { | r | r[:email] }
    end

    def has_recipient_names?
      @recipients.all? { | r | r[:name] }
    end

    def has_valid_recipients?
      has_recipient_emails? && has_recipient_names?
    end
  end

  class Game
    attr_accessor :players, :num_teams, :teams, :clues, :current_player_ix, :current_team, :current_round, :lineup

    MIN_NUM_PLAYERS = 6

    def initialize players, num_teams = 2
      @num_teams = num_teams
      @players = create_players players
      @teams = create_teams num_teams
      @clues = collect_clues
      @current_player_ix = 0
      @current_team = nil
      @current_round = start_round
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

  class Round
    attr_accessor :remaining_clues, :completed_clues, :type

    ROUND_TYPES = [
      'UNLIMITED_WORDS',
      'ONE_WORD',
      'CHARADES'
    ]

    def initialize current_player_ix, teams, clues, game
      @current_player_ix = current_player_ix
      @teams = teams
      @remaining_clues = clues
      @completed_clues = []
      @type = ROUND_TYPES[0]
      @game = game
    end

    def new_turn
      Turn.new(@remaining_clues, @current_player_ix)
    end

    def next_player
      @game.get_next_player
    end

    def update_score
    end

  end

  class Turn
    attr_accessor :timer, :remaining_clues, :completed_clues, :score, :current_clue

    def initialize clues, player
      @player = player
      @remaining_clues = clues
      @completed_clues = []
      @timer = Timer.new
      @score = 0
      @current_clue = @remaining_clues.shift

      @timer.add_observer self
      @timer.run

    end

    def guessed_clue
      update_as_guessed_correctly
    end

    def skipped_clue
      update_as_skipped
    end

    def get_score
      @score
    end

    def update
      # end of Turn
    end

    private

    def update_as_guessed_correctly
      set_next_clue
      increment_score
    end

    def update_as_skipped
      send_clue_to_back
      decrement_score
    end

    def increment_score
      @score += 1
    end

    def decrement_score
      @score -= 1
    end

    def set_next_clue
      @completed_clues << @current_clue = @remaining_clues.shift
    end

    def send_clue_to_back
      @remaining_clues << @current_clue
      @current_clue = @remaining_clues.shift
    end

    class Timer
      include Observable
      attr_accessor :thread

      def initialize time = 60
        @started = false
        @finished = false
        @time = time
      end

      def run
        @started = true
        @thread = Thread.new do
          while @time > 0 do
            @time -= 1
            sleep(1)
          end
          changed
          notify_observers
          @finished = true
        end
      end

      def started?
        @started
      end

      def finished?
        @finished
      end
    end
  end

  class Player
    attr_accessor :name, :clues, :team
    def initialize name, clues = [], team = nil
      @name = name
      @clues = clues
      @team = team
    end
  end

  class Team
    attr_accessor :name, :score, :players, :player_ix
    def initialize name, players
      @name = name
      @players = players
      @score = 0
      @player_ix = 0
    end

  end
end
