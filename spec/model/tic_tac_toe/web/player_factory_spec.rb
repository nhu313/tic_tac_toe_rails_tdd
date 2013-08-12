require 'spec_helper'
require 'tic_tac_toe/web/player_factory'
require 'tic_tac_toe/web/player'

describe TicTacToe::WebPlayerFactory do
  before(:each) do
    @factory = TicTacToe::WebPlayerFactory.new
    @value = TicTacToe::VALUES[0]
  end

  context "human player" do
    before(:each) do
      @human = @factory.human(@value)
    end

    it "should have no strategy" do
      @human.strategy.should be_nil
    end

    it "should need input" do
      @human.should be_needs_input
    end

    it "checks default human name" do
      @human.name.should == "User"
    end

    it "checks value" do
      @human.value.should == @value
    end
  end

  context "computer player" do
    before(:each) do
      @computer = @factory.computer(@value)
    end

    it "should have no strategy" do
      @computer.strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "should not need input" do
      @computer.should_not be_needs_input
    end

    it "checks default name" do
      @computer.name.should == "Computer"
    end

    it "checks value" do
      @computer.value.should == @value
    end
  end
end
