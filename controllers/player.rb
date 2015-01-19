class Player
  attr_accessor :name, :clues, :team
  def initialize name, clues = [], team = nil
    @name = name
    @clues = clues
    @team = team
  end
end
