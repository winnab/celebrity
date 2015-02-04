class Team
  attr_accessor :name, :score, :players, :player_ix
  def initialize name, players
    @name = name
    @players = players
    @score = 0
    @player_ix = 0
  end

end
