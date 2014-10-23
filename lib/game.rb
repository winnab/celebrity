module Game
  class Setup
  end

  class Play
    attr_accessor :players, :num_teams, :teams

    def initialize players, num_teams = 2
      @players = players
      @num_teams = num_teams
      puts "about to assign teams"
      @teams = create_teams players, num_teams
      puts "teams: #{@teams}"
    end

    def create_teams players, num_teams
      teams = []
      players.shuffle!
      players_per_team = (players.length / num_teams).floor
      players.each_slice(players_per_team) { | p | teams << p }
      teams
    end
  end

  class Players
  end

  class Teams
  end
end
