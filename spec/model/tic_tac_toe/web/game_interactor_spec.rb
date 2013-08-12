require 'spec_helper'
require 'tic_tac_toe/web/game_interactor'
require 'tic_tac_toe/board'
require 'mocks/game'
require 'mocks/player'
require 'mocks/game_factory'

describe TicTacToe::WebGameInteractor do
  attr_reader :game_interactor, :game, :player, :board, :move

  before(:each) do
    @game = MockGame.new
    @game_interactor = TicTacToe::WebGameInteractor.new

    @move = 2
    @board = TicTacToe::Board.new
    @player = MockWebPlayer.new("player1", "X", nil)

    game.will_have_current_player @player
    game.will_have_board @board
  end

  context "makes move" do
    it "tells game to make player moves" do
      game_interactor.make_move(game, move)
      game.was told_to(:make_player_move).with(move)
    end

    it "tells game to make player move until player needs an input" do
      player.will_needs_input? false, false, false, true
      game.will_have_over? false

      game_interactor.make_move(game, move)
      game.was told_to(:make_player_move).times(4)
    end

    it "tells game to make move until the game is over" do
      game.will_over? false, false, true
      game_interactor.make_move(game, 1)
      game.was told_to(:make_player_move).times(3)
    end
  end

  it "creates a game based on user input" do
    game_factory = MockGameFactory.new
    game_factory.will_create game
    game_interactor.game_factory = game_factory
    game_type = 3

    game_interactor.create_game(game_type)

    game_factory.was told_to(:create).with(game_type)
  end
end
