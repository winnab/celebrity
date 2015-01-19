require_relative "timer"
require 'observer'

class Turn
  attr_accessor :timer, :remaining_clues, :completed_clues, :score, :current_clue
  attr_reader :round

  def initialize clues, player, round
    @player = player
    @remaining_clues = clues
    @completed_clues = []
    @round = round
    @timer = Timer.new
    @score = 0
    @current_clue = @remaining_clues.shift
    @timer.add_observer self
    @timer.run
  end

  def guessed_clue
    update_as_guessed_correctly
  end

  def skipped_clue
    update_as_skipped
  end

  def get_score
    @score
  end

  def update
    unguessed_clues = @remaining_clues + [@current_clue]
    @round.turn_completed(unguessed_clues, @completed_clues, get_score)
  end

  private

  def update_as_guessed_correctly
    set_next_clue
    increment_score
  end

  def update_as_skipped
    send_clue_to_back
    decrement_score
  end

  def increment_score
    @score += 1
  end

  def decrement_score
    @score -= 1
  end

  def set_next_clue
    @completed_clues << @current_clue = @remaining_clues.shift
  end

  def send_clue_to_back
    @remaining_clues << @current_clue
    @current_clue = @remaining_clues.shift
  end
end
