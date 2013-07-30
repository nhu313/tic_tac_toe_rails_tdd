require 'surrogate/rspec'
require 'tic_tac_toe/game_state_factory'

class MockGameStateFactory
  Surrogate.endow(self)
  define(:initialize) {|player_factory = "none"|}
  define :types
  define(:create) {|type|}
end

describe TicTacToe::GameStateFactory do
  it "checks MockGameState" do
    MockGameStateFactory.should be_substitutable_for(TicTacToe::GameStateFactory)
  end
end
