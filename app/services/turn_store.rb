class TurnStore
  def initialize
    @store = []
  end

  def list
    store
  end

  def add turn
    store << turn unless store.include?(turn)
  end

  def find_all_by_game_id game_id
    store.select { |turn| turn.game_id == game_id }
  end

  private

  attr_accessor :store
end
