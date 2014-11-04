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
    attr_accessor :players, :num_teams, :teams
    attr_reader :current_player

    MIN_NUM_PLAYERS = 6

    def initialize players, num_teams = 2
      @num_teams = num_teams
      @players = players
      @teams = create_teams players, num_teams
    end

    def create_teams players, num_teams
      players.shuffle!
      players_per_team = (players.length / num_teams).floor
      players_by_team = []
      teams = []
      players.each_slice(players_per_team) do | group |
        players = []
        group.each do | p |
          players << Player.new(p[:name], p[:clues])
        end
        players_by_team << players
      end
      num_teams.times do | i |
        teams << Team.new(players_by_team[i])
      end
      teams
    end

    def can_start?
      has_teams? && has_players? && has_clues? && sufficient_players? && sufficient_clues?
    end

    def has_teams?
      @teams.all? { | t | t.size > 2 }
    end

    def has_players?
      @players.all? { | p | p[:name] }
    end

    def has_clues?
      @players.all? { | p | p[:clues] }
    end

    def sufficient_players?
      @players.length >= MIN_NUM_PLAYERS
    end

    def sufficient_clues?
      total = @players.reduce(0) { | ret, p | ret += p[:clues].length }
      total >= ( @players.length * 4 )
    end

    def current_player
      return @players[0]
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
