class GamesPresenter
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def squares
    game.board.squares
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
  attr_reader :game

  def winner
    game.winner
  end

  def game_over?
    game.over?
  end

  def current_player
    game.current_player
  end
end
