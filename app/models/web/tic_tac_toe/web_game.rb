require 'web/tic_tac_toe/web_player_factory'
require 'tic_tac_toe/game_state_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class WebGame

    def create_game_state(game_type)
      player_factory = TicTacToe::WebPlayerFactory.new
      @game_factory ||= TicTacToe::GameStateFactory.new(player_factory)
      game_state = @game_factory.create(game_type.to_i)
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
      until game_state.current_player.needs_input? || rules(game_state).game_over?
        game_state.current_player.move(game_state.board)
        game_state.change_player
      end
    end

    def rules(game_state)
      @rules ||= TicTacToe::Rules.new(game_state.board)
    end
  end
end
