require_relative './turn'

class Round
  attr_accessor :id, :remaining_clues, :completed_clues, :type, :game_id

  ROUND_TYPES = [
    'UNLIMITED_WORDS',
    'ONE_WORD',
    'CHARADES'
  ]

  def initialize current_player_ix, teams, clues, game
    @id = SecureRandom.uuid
    @current_player_ix = current_player_ix
    @teams = teams
    @remaining_clues = clues
    @completed_clues = []
    @type = ROUND_TYPES[0]
    @game = game
    @game_id = game.id
  end

  def new_turn
    Turn.new(@remaining_clues, @current_player_ix, self)
  end

  def next_player
    @game.get_next_player
  end

  def update_score
  end

  def turn_completed unguessed_clues, completed_clues, get_score
  end
end
