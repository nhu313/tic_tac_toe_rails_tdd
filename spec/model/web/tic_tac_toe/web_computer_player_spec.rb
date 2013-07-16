require 'spec_helper'

describe TicTacToe::WebComputerPlayer do
  it "doesn't require user input" do
    TicTacToe::WebComputerPlayer.new(nil, nil, nil).should_not be_needs_input
  end
end
