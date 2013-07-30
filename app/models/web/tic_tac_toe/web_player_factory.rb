require 'web/tic_tac_toe/web_player'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/values'

module TicTacToe
  class WebPlayerFactory

    def human(name = "You", value = TicTacToe::VALUES[0])
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

    # def human(name = "You", value = TicTacToe::VALUES[0])
    #   TicTacToe::WebUserPlayer.new(name, value)
    # end
    #
    # def computer(value = TicTacToe::VALUES[1])
    #   ai = TicTacToe::Strategy::Minimax.new(value)
    #   TicTacToe::WebComputerPlayer.new("Computer", value, ai)
    # end
  end
end
