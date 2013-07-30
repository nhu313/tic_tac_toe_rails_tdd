require 'tic_tac_toe/web/player_factory'
require 'tic_tac_toe/game_state_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class WebGame
    attr_writer :game_state_factory

    def create_game_state(game_type)
      player_factory = TicTacToe::WebPlayerFactory.new
      @game_state_factory ||= TicTacToe::GameStateFactory.new(player_factory)
      game_state = @game_state_factory.create(game_type)
      play_game(game_state)
      game_state
    end

    def make_move(game_state, move)
      game_state.board.mark(move, game_state.current_player.value)
      game_state.change_player
      play_game(game_state)
    end

    private
    attr_reader :game_state

    def play_game(game_state)
      until game_state.current_player.needs_input? || game_state.game_over?
        game_state.current_player.move(game_state.board)
        game_state.change_player
      end
    end
  end
end