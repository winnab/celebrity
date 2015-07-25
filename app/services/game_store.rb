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

  def add_clues_to_game game_id, clues
    game = store.find { |game| game.id == game_id }
    game.add_clues(clues)
  end

  private

  attr_accessor :store
end
