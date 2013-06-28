require 'spec_helper'
require 'tic_tac_toe/web_user_player'

describe TicTacToe::WebUserPlayer do
  before(:each) do
    @player = TicTacToe::WebUserPlayer.new("Sam", "O")
  end

  it "has name" do
    @player.name.should == "Sam"
  end

  it "has value" do
    @player.value.should == "O"
  end

  it "needs user input" do
    @player.should be_needs_input
  end

  context "move" do
    it "has no move after creation" do
      @player.move.should be_nil
    end

    it "adds a move" do
      @player.add_move(4)
    end

    it "returns the move added when asks for a move" do
      @player.add_move(1)
      @player.move.should == 1
    end

    it "removes the move after it returns the move" do
      @player.add_move(2)
      @player.move
      @player.move.should be_nil
    end
  end
end
