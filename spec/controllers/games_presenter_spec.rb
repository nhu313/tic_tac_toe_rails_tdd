require 'spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/values'
require 'tic_tac_toe/game_state'
require 'mocks/game_state'

describe GamesPresenter do
  attr_reader :presenter, :game_state, :player1

  before(:each) do
    @player1 = create_player("player1", TicTacToe::VALUES[0])
    # @player2 = create_player("player2", TicTacToe::VALUES[1])
    # @game_state = TicTacToe::GameState.new([@player1, @player2])
    @game_state = MockGameState.factory
    @presenter = GamesPresenter.new(@game_state)
  end

  def create_player(name, value)
    TicTacToe::WebPlayerFactory.new.human(name, value)
  end

  it "gets the board square" do
    board = TicTacToe::Board.new
    game_state.will_have_board board
    presenter.squares.should == board.squares
  end

  describe "links square" do
    it "is true if the square is not mark and game is not over" do
      game_state.will_game_over? false
      presenter.should be_link(nil)
    end

    it "is false if the square is not marked and the game is over" do
      game_state.will_game_over? true
      presenter.should_not be_link(nil)
    end

    it "is false if the square is marked" do
      game_state.will_game_over? false
      presenter.should_not be_link(player1.value)
    end
  end

  describe "game message" do
    it "displays current player turn when game is not over" do
      game_state.will_game_over? false
      game_state.will_have_current_player player1

      presenter.message.should == "#{player1.name} (#{player1.value}), please select a square."
    end

    it "displays winner when there is a winner" do
      game_state.will_have_winner player1
      presenter.message.should == "#{player1.name} (#{player1.value}) wins!"
    end

    it "displays a draw when game is over and there is no winner" do
      game_state.will_game_over? true
      game_state.will_have_winner nil
      presenter.message.should == "It's a draw!"
    end
  end
end
