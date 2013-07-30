require 'spec_helper'
require 'mocks/game_state'
require 'mocks/game'

describe GamesController do
  attr_reader :controller, :game, :game_state

  before(:each) do
    @controller = GamesController.new
    @game_state = MockGameState.new
    @game = MockWebGame.new
    @controller.game = @game
  end

  context "new" do
    it "gets new game" do
      post :new
      response.should be_success
    end

    it "creates a new game based on user input" do
      post :new, type:2
      game.was asked_for(:create_game_state).with(2)
    end
  end

  context "play" do
    it "gets the play page" do
      get :play
      response.should be_success
    end

    it "returns a list of all the available game type" do
      get :play
      assigns[:types].should == [[:human, :computer], [:computer, :human], [:human, :human], [:computer, :computer]]
    end
  end

  context "make move" do
    before (:each) do
      post :new
    end

    it "post to move" do
      post :move
      response.should be_success
    end

    it "tells game to make move" do
      move = "3"
      request.session[:game_state] = game_state
      post :move, move: move
      game.was told_to(:make_move).with(game_state, move.to_i)
    end
  end

end
