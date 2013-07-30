require 'tic_tac_toe/rules'

class Presenter

  def initialize(game_state)
    @game_state = game_state
  end

  def game_over?
    rules.game_over?
  end

  private
  attr_reader :game_state

  def rules
    TicTacToe::Rules.new(game_state.board)
  end

end
