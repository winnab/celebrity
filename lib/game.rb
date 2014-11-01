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
    MIN_NUM_PLAYERS = 6

    def initialize players, num_teams = 2
      @players = players
      @num_teams = num_teams
      @teams = create_teams players, num_teams
    end

    def create_teams players, num_teams
      teams = []
      players.shuffle!
      players_per_team = (players.length / num_teams).floor
      players.each_slice(players_per_team) { | p | teams << p }
      teams.each { | t | Team.new(t) }
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
  end

  class Players
  end

  class Team
    attr_accessor :score, :players

    def initialize players
      @players = players
      @score = 0
    end

  end
end
