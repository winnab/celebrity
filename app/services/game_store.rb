class GameStore
  # create game
  # list games
  # delete game

  def initialize
    @store = []
  end

  def list
    store
  end

  def add game
    store << game unless store.include?(game)
  end

  def find game_id
    store.find { |game| game.id == game_id }
  end

  private

  attr_accessor :store
end
