class Round
  attr_accessor :remaining_clues, :completed_clues, :type

  ROUND_TYPES = [
    'UNLIMITED_WORDS',
    'ONE_WORD',
    'CHARADES'
  ]

  def initialize current_player_ix, teams, clues, game
    @current_player_ix = current_player_ix
    @teams = teams
    @remaining_clues = clues
    @completed_clues = []
    @type = ROUND_TYPES[0]
    @game = game
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

    #
  end
end
