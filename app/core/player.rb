class Player
  attr_accessor :game_id, :name, :clues, :team
  def initialize game_id, name, team = nil
    @game_id = game_id
    @name = name
    @team = team
  end
end
