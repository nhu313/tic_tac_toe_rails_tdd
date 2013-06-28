require 'spec_helper'
require 'games_presenter'
require 'tic_tac_toe/board'
require 'mocks/game'
require 'mocks/rules'
require 'mocks/web_user_player'
require 'mocks/game_factory'

describe GamesPresenter do

  before(:each) do
    @rules = MockRules.new("board")
    @game = MockGame.new
    @presenter = GamesPresenter.new(@game)
    @presenter.rules = @rules
  end

  context "ensure mock class has the same interface" do
    it "checks MockGame" do
      MockGame.should be_substitutable_for(TicTacToe::Game)
    end

    it "checks game factory" do
      MockGameFactory.should be_substitutable_for(TicTacToe::GameFactory)
    end

    it "checks rules" do
      MockRules.should be_substitutable_for(TicTacToe::Rules)
    end
  end


  it "returns a player" do
    winner = "winner"
    @game.will_have_player winner
    @presenter.winner.should == winner
    @rules.was asked_for(:winner)
  end

  it "returns game over" do
    game_over = true
    @rules.will_game_over? game_over
    @presenter.should be_game_over
    @rules.was asked_for(:game_over?)
  end

  context "makes move" do
    before(:each) do
      @player = MockWebUserPlayer.new("Andrea", "O")
      @game.will_have_current_player @player
    end

    it "adds a move to player if user passed in a move" do
      @presenter.make_move(4)
      @player.was told_to(:add_move).with(4)
    end

    it "doesn't add a move if user didn't passed in a move" do
      @presenter.make_move(nil)
      @player.was_not told_to(:add_move)
    end

    it "asks game to make move" do
      @presenter.make_move(1)
      @game.was told_to(:make_move)
    end

    it "tells game to make move until player needs input" do
      @rules.will_game_over? false
      @player.will_needs_input? false, true
      @presenter.make_move(1)
      @game.was told_to(:make_move).times(2)
    end

    it "tells game to make move until the game is over" do
      @rules.will_game_over? false, false, true
      @presenter.make_move(1)
      @game.was told_to(:make_move).times(3)
    end
  end

  it "creates a game based on user input" do
    @game_factory = MockGameFactory.factory create: @game
    @presenter.game_factory = @game_factory
    type = "3"
    @presenter.create_game(type).should == @game
    @game_factory.was told_to(:create)
  end

  it "returns the game squares" do
    board = TicTacToe::Board.new
    @game.will_have_board board
    @presenter.squares.should == board.squares
  end
end
