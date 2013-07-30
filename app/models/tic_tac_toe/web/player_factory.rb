require 'tic_tac_toe/web/player'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/values'

module TicTacToe
  class WebPlayerFactory

    def human(name = "User", value = TicTacToe::VALUES[0])
      create_player(name, value, nil, true)
    end

    def computer(value = TicTacToe::VALUES[1])
      ai = TicTacToe::Strategy::Minimax.new(value)
      create_player("Computer", value, ai, false)
    end

    private
    def create_player(name, value, strategy, needs_input)
      player = TicTacToe::WebPlayer.new(name, value, strategy)
      player.needs_input = needs_input
      player
    end
  end
end
