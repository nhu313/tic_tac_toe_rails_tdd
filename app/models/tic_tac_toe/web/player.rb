require 'tic_tac_toe/player'

module TicTacToe
  class WebPlayer < TicTacToe::Player

    attr_accessor :needs_input
    alias :needs_input? :needs_input
  end
end
