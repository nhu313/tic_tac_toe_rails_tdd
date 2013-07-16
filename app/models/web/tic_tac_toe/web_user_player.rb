module TicTacToe
  class WebUserPlayer
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
      @moves = []
    end

    def add_move(move)
      @moves << move
    end

    def move
      @moves.shift
    end

    def needs_input?
      true
    end
  end
end
