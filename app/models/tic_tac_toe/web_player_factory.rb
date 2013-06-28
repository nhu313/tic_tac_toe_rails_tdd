require 'tic_tac_toe/web_user_player'
require 'tic_tac_toe/web_computer_player'
require 'tic_tac_toe/strategy/minimax'

module TicTacToe
  class WebPlayerFactory

    def human(name = "You", value = "X")
      TicTacToe::WebUserPlayer.new(name, value)
    end

    def computer(board, value = "O", opponent_value = "X")
      ai = TicTacToe::Strategy::Minimax.new(board, value, opponent_value)
      TicTacToe::WebComputerPlayer.new("Computer", value, ai)
    end
  end
end
