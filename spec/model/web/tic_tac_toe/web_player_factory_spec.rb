require 'spec_helper'
require 'web/tic_tac_toe/web_player_factory'
require 'web/tic_tac_toe/web_user_player'

describe TicTacToe::WebPlayerFactory do
  before(:each) do
    @factory = TicTacToe::WebPlayerFactory.new
  end

  context "human player" do
    it "returns web player with passed in values" do
      name = "Billy"
      value = "bill"
      player = @factory.human(name, value)
      player.name.should == name
      player.value.should == value
    end

    it "checks human player is a web user player" do
      @factory.human.should be_kind_of(TicTacToe::WebUserPlayer)
    end

    it "checks default human name" do
      @factory.human.name.should == "You"
    end

    it "checks default human value" do
      @factory.human.value.should == "X"
    end
  end

  context "computer player" do
    it "returns a computer player with given value" do
      computer_value = "Danny"
      player = @factory.computer("board", computer_value, "opponent")
      player.value.should == computer_value
    end

    it "checks computer strategy" do
      @factory.computer("board").strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "checks default computer value" do
      @factory.computer("board").value.should == "O"
    end
  end
end
