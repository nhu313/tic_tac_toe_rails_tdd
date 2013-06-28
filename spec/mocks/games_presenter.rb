require 'surrogate/rspec'

class MockGamesPresenter
  Surrogate.endow(self)
  define_writer :rules
  define_writer :game_factory

  define(:initialize) {|game|}
  define(:make_move){|move|}
  define(:create_game) {|type|}
  define(:game_over?)
  define(:winner)
  define(:squares)
end
