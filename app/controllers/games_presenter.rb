require 'tic_tac_toe/rules'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'
require 'tic_tac_toe/web_player_factory'
require 'games_presenter'


class GamesPresenter
  attr_writer :rules, :game_factory

  def initialize(game)
    @game = game
  end

  def make_move(player_move)
    game.current_player.add_move(player_move.to_i) if player_move
    game.make_move
    play
  end

  def create_game(type)
    player_factory = TicTacToe::WebPlayerFactory.new
    game_factory = @game_factory || TicTacToe::GameFactory.new(player_factory)
    @game = game_factory.create(type.to_i, TicTacToe::Board.new)
    play
    @game
  end

  def game_over?
    rules.game_over?
  end

  def winner
    game.player(rules.winner)
  end

  def squares
    game.board.squares
  end

  private
  attr_reader :game

  def rules
    @rules = @rules || TicTacToe::Rules.new(game.board)
  end

  def play
    game.make_move until game_over? || game.current_player.needs_input?
  end
end
