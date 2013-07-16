require 'spec_helper'
require 'mocks/game'
require 'mocks/game_interactor'

describe GamesController do
  before(:each) do
    @controller = GamesController.new
    @game = MockGame.new
    @main = MockGameInteractor.new(@game)
    @main.will_have_create_game @game
    @controller.main = @main
  end

  it "checks MockGame" do
    MockGame.should be_substitutable_for(TicTacToe::Game)
  end

  it "checks resenter" do
    MockGameInteractor.should be_substitutable_for(TicTacToe::GameInteractor)
  end

  context "new" do
    it "gets new game" do
      post :new
      response.should be_success
    end

    it "creates a new game based on user input" do
      post :new, type:2
      @main.was asked_for(:create_game).with("2")
    end
  end

  context "play" do
    it "gets the play page" do
      get :play
      response.should be_success
    end

    it "returns a list of all the available game type" do
      get :play
      assigns[:types].should == ["You vs Computer", "Computer vs You", "You vs Friend", "Computer vs Computer"]
    end
  end

  context "move" do
    before (:each) do
      post :new
    end

    it "post to move" do
      post :move
      response.should be_success
    end

    it "tells presenter to make move" do
      move = "3"
      post :move, move: move
      @main.was told_to(:make_move).with(move)
    end

    it "initialize game instance variable" do
      assigns[:game].should == @game
    end
  end

end
