module TicTacToe
  class WebMain

    attr_writer :game_factory

    def initialize(game)
      @game = game
    end

    def make_move(player_move)
      game.current_player.add_move(player_move.to_i) if player_move
      game.make_move
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
