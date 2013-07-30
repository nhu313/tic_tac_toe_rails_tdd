require 'surrogate/rspec'

class MockWebPlayer
  attr_accessor :name, :value
  Surrogate.endow(self)
  define(:initialize) do |name, value, strategy|
    @name = name
    @value = value
  end
  define_reader(:name)
  define_reader(:value)
  define_reader(:strategy)
  define_accessor(:needs_input)
  define_reader(:needs_input?)

  define(:move){|board|}
end

describe TicTacToe::WebPlayer do
  it "checks MockGameState" do
    MockWebPlayer.should be_substitutable_for(TicTacToe::WebPlayer)
  end
end
