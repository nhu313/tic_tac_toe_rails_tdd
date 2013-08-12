require 'surrogate/rspec'

class MockWebGameInteractor
  Surrogate.endow(self)
  define_writer :game_factory
  define(:make_move) {|game_state, player_move|}
  define(:create_game) {|type|}
end

describe TicTacToe::WebGameInteractor do
  it "checks if substituable" do
    MockWebGameInteractor.should be_substitutable_for(TicTacToe::WebGameInteractor)
  end
end
