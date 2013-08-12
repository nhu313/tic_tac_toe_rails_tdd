require 'surrogate/rspec'

class MockGameFactory
  Surrogate.endow(self)
  define(:initialize) {|player_factory = "none"|}
  define :types
  define(:create) {|type|}
end

describe TicTacToe::GameFactory do
  it "checks MockGameFactory" do
    MockGameFactory.should be_substitutable_for(TicTacToe::GameFactory)
  end
end
