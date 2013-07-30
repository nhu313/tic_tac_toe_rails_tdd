require 'spec_helper'
require 'tic_tac_toe/web/player_factory'
require 'tic_tac_toe/web/player'

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

    it "checks default human name" do
      @factory.human.name.should == "User"
    end

    it "checks default human value" do
      @factory.human.value.should == "X"
    end
  end

  context "computer player" do
    it "returns a computer player with given value" do
      computer_value = "Danny"
      player = @factory.computer(computer_value)
      player.value.should == computer_value
    end

    it "checks computer strategy" do
      @factory.computer.strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "checks default computer value" do
      @factory.computer.value.should == "O"
    end
  end
end
