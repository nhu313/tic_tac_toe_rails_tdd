require 'spec_helper'
require 'tic_tac_toe/web/player'

describe TicTacToe::WebPlayer do

  it "can specify whether or not user needs input" do
    player = TicTacToe::WebPlayer.new("name", "value", nil)
    player.needs_input = true
    player.needs_input.should be_true
  end
end
