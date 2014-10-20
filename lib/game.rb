module Game
  class Setup
  end

  class Play
    attr_accessor :players, :num_teams, :teams
    def initialize players, num_teams = 2
      @players = players
      @num_teams = num_teams
    end

    def create_teams players, num_teams
      @teams = []
      players_per_team = Math.floor(players / num_teams)
      players.shuffle
      num_teams.times do | assign |
        @teams << players
      end
    end
  end

  class Players
  end

  class Teams
  end
end
