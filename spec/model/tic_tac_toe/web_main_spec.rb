require 'spec_helper'
require 'tic_tac_toe/web_main'
require 'tic_tac_toe/board'
require 'mocks/game'
require 'mocks/web_user_player'
require 'mocks/game_factory'

describe TicTacToe::WebMain do

  before(:each) do
    @game = MockGame.new
    @main = TicTacToe::WebMain.new(@game)
  end

  context "ensure mock class has the same interface" do
    it "checks MockGame" do
      MockGame.should be_substitutable_for(TicTacToe::Game)
    end

    it "checks game factory" do
      MockGameFactory.should be_substitutable_for(TicTacToe::GameFactory)
    end
  end

  context "makes move" do
    before(:each) do
      @player = MockWebUserPlayer.new("Andrea", "O")
      @game.will_have_current_player @player
    end

    it "adds a move to player if user passed in a move" do
      @main.make_move(4)
      @player.was told_to(:add_move).with(4)
    end

    it "doesn't add a move if user didn't passed in a move" do
      @main.make_move(nil)
      @player.was_not told_to(:add_move)
    end

    it "asks game to make move" do
      @main.make_move(1)
      @game.was told_to(:make_move)
    end

    it "tells game to make move until player needs input" do
      @game.will_over? false
      @player.will_needs_input? false, true
      @main.make_move(1)
      @game.was told_to(:make_move).times(2)
    end

    it "tells game to make move until the game is over" do
      @game.will_over? false, false, true
      @main.make_move(1)
      @game.was told_to(:make_move).times(3)
    end
  end

  it "creates a game based on user input" do
    @game_factory = MockGameFactory.factory create: @game
    @main.game_factory = @game_factory
    type = "3"
    @main.create_game(type).should == @game
    @game_factory.was told_to(:create)
  end
end
