require 'surrogate/rspec'

class MockWebMain
  Surrogate.endow(self)
  define(:initialize) {|game|}
  define_writer(:game_factory)
  define(:make_move) {|player_move|}
  define(:create_game) {|type|}
end
