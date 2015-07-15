class PlayerStore
  # create player
  # list players
  # delete player

  def initialize
    @store = []
  end

  def list
    store
  end

  def add player
    store << player unless store.include?(player)
  end

  def find_all_by_game_id game_id
    store.select { |player| player.game_id == game_id }
  end

  private

  attr_accessor :store
end
