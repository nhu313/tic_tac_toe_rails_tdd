require 'surrogate/rspec'

class MockWebUserPlayer
  Surrogate.endow(self)
  define(:initialize) {|name, value|}
  define_reader(:name)
  define_reader(:value)
  define(:add_move) {|move|}
  define(:move)
  define(:needs_input?)
end
