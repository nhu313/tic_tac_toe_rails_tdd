require 'surrogate/rspec'

class MockWebGame
  Surrogate.endow(self)
  define_writer :game_state_factory
  define(:make_move) {|game_state, player_move|}
  define(:create_game_state) {|type|}
end

describe TicTacToe::WebGame do
  it "checks if substituable" do
    MockWebGame.should be_substitutable_for(TicTacToe::WebGame)
  end
end
