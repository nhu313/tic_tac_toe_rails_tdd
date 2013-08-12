require 'spec_helper'
require 'mocks/game'
require 'mocks/game_interactor'

describe GamesController do
  attr_reader :controller, :game_interactor, :game

  before(:each) do
    @controller = GamesController.new
    @game = MockGame.new
    @game_interactor = MockWebGameInteractor.new
    @controller.game_interactor = @game_interactor
  end

  context "new" do
    it "gets new game" do
      post :new
      response.should be_success
    end

    it "creates a new game based on user input" do
      post :new, type:2
      game_interactor.was asked_for(:create_game).with(2)
    end
  end

  context "play" do
    it "gets the play page" do
      get :play
      response.should be_success
    end

    it "returns a list of all the available game type" do
      get :play
      assigns[:types].should == [[:human, :human], [:human, :computer], [:computer, :human], [:computer, :computer]]
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
      request.session[:game] = game
      post :move, move: move
      game_interactor.was told_to(:make_move).with(game, move.to_i)
    end
  end

end
