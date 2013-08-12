require 'tic_tac_toe/web/player_factory'
require 'tic_tac_toe/game_factory'

module TicTacToe
  class WebGameInteractor
    attr_writer :game_factory

    def create_game(game_type)
      player_factory = TicTacToe::WebPlayerFactory.new
      @game_factory ||= TicTacToe::GameFactory.new(player_factory)
      game = @game_factory.create(game_type)
      play_game(game)
      game
    end

    def make_move(game, move)
      game.make_player_move(move)
      play_game(game)
    end

    private
    def play_game(game)
      game.make_player_move until game.current_player.needs_input? || game.over?
    end
  end
end
