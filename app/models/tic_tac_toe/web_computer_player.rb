require 'tic_tac_toe/player'

module TicTacToe
  class WebComputerPlayer < TicTacToe::Player
    def needs_input?
      false
    end
  end
end
