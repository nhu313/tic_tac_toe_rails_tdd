require 'spec_helper'
require 'tic_tac_toe/web/game'
require 'tic_tac_toe/board'
require 'mocks/game_state'
require 'mocks/player'
require 'mocks/game_factory'

describe TicTacToe::WebGame do
  attr_reader :game, :game_state, :player, :board, :move

  before(:each) do
    @game_state = MockGameState.new
    @game = TicTacToe::WebGame.new

    @move = 2
    @board = TicTacToe::Board.new
    @player = MockWebPlayer.new("player1", "X", nil)

    game_state.will_have_current_player @player
    game_state.will_have_board @board
  end

  context "makes move" do
    it "marks the board with current player value" do
      game.make_move(game_state, move)
      board.available_moves.should_not include(move)
      board.unique_marked_values.should include(player.value)
    end

    it "changes the current player" do
      game.make_move(game_state, move)
      game_state.was told_to(:change_player)
    end

    it "tells player to make move until player needs an input" do
      player.will_needs_input? false, false, false, true
      game_state.will_have_game_over? false

      game.make_move(game_state, move)
      player.was told_to(:move).times(3)
      game_state.was told_to(:change_player).times(4)
    end

    it "changes player until game is over" do
      game_state.will_game_over? false, true
      game.make_move(game_state, move)
      game_state.was told_to(:change_player).times(2)
    end

    it "tells game to make move until the game is over" do
      game_state.will_game_over? false, false, true
      game.make_move(game_state, 1)
      player.was told_to(:move).times(2)
    end
  end

  it "creates a game based on user input" do
    game_state_factory = MockGameStateFactory.new
    game_state_factory.will_create game_state
    game.game_state_factory = game_state_factory
    game_type = 3

    game.create_game_state(game_type)

    game_state_factory.was told_to(:create).with(game_type)
  end
end
