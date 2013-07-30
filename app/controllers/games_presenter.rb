require 'tic_tac_toe/rules'

class GamesPresenter
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
  end

  def squares
    game_state.board.squares
  end

  def link?(value)
    return false if value
    !game_over?
  end

  def message
    return "#{winner.name} (#{winner.value}) wins!" if winner
    return "It's a draw!" if game_over?
    "#{current_player.name} (#{current_player.value}), please select a square."
  end

  private
  attr_reader :game_state

  def winner
    game_state.winner
  end

  def game_over?
    game_state.game_over?
  end

  def current_player
    game_state.current_player
  end
end
