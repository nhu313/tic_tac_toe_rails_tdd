require 'tic_tac_toe/web/player'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class WebPlayerFactory < TicTacToe::PlayerFactory

    def human(value)
      create_web_player("User", value, nil, true)
    end

    def computer(value)
      ai = TicTacToe::Strategy::Minimax.new(value)
      create_web_player("Computer", value, ai, false)
    end

    private
    def create_web_player(name, value, strategy, needs_input)
      player = TicTacToe::WebPlayer.new(name, value, strategy)
      player.needs_input = needs_input
      player
    end
  end
end
