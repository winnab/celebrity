class RoundStore
  def initialize
    @store = []
  end

  def list
    store
  end

  def add round
    binding.pry
    store << round unless store.include?(round)
  end

  def find_all_by_game_id game_id
    store.select { |round| round.game_id == game_id }
  end

  def find round_id
    store.find { |round| round.id == round_id }
  end

  private

  attr_accessor :store
end
