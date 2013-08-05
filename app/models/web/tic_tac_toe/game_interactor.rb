require 'web/tic_tac_toe/web_player_factory'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class GameInteractor

    attr_writer :game_factory

    def initialize(game)
      @game = game
    end

    def make_move(player_move)
      game.make_move(player_move.to_i)
      play
    end

    def create_game(type)
      player_factory = TicTacToe::WebPlayerFactory.new
      @game_factory ||= TicTacToe::GameFactory.new(player_factory)
      @game = @game_factory.create(type.to_i, TicTacToe::Board.new)
      play
      @game
    end

    private
    attr_reader :game

    def play
      game.make_move until game.over? || game.current_player.needs_input?
    end
  end
end
