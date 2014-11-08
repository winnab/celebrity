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
    attr_accessor :players, :num_teams, :teams, :clues, :current_player, :current_round

    MIN_NUM_PLAYERS = 6

    def initialize players, num_teams = 2
      @num_teams = num_teams
      @players = create_players players
      @teams = create_teams num_teams
      @clues = collect_clues
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
        teams << Team.new(players_by_team[i])
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
      @players[0]
    end

    def start_round
      Round.new(@current_player, @teams, @clues)
    end
  end

  class Round
    attr_accessor :remaining_clues, :completed_clues, :type

    ROUND_TYPES = [
      'UNLIMITED_WORDS',
      'ONE_WORD',
      'CHARADES'
    ]

    def initialize current_player, teams, clues
      @current_player = current_player
      @teams = teams
      @remaining_clues = clues
      @completed_clues = []
      @type = ROUND_TYPES[0]
    end

    def new_turn
      Turn.new(@remaining_clues)
    end

    def update_score
    end

  end

  class Turn
    attr_accessor :remaining_time, :remaining_clues, :completed_clues, :score

    def initialize clues
      @remaining_clues = clues
      @completed_clues = []
      @remaining_time = 60
      @score = 0
      @current_clue = nil
    end

    def show_new_clue
      @current_clue = @remaining_clues[0]
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

    private

    def update_as_guessed_correctly
      add_clue_to_completed
      remove_clue_from_remaining
      show_new_clue
      increment_score
    end

    def update_as_skipped
      move_clue_to_end_of_remaining
      show_new_clue
      decrement_score
    end

    def add_clue_to_completed
      @completed_clues.push(@current_clue)
    end

    def remove_clue_from_remaining
      @remaining_clues.slice!(0)
    end

    def move_clue_to_end_of_remaining
      @remaining_clues.rotate(1)
    end

    def increment_score
      @score += 1
      return self
    end

    def decrement_score
      @score += 1
      return self
    end



  end

  class Player
    attr_accessor :name, :clues
    def initialize name, clues = []
      @name = name
      @clues = clues
    end
  end

  class Team
    attr_accessor :score, :players
    def initialize players
      @players = players
      @score = 0
    end
  end
end
