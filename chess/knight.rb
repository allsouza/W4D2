require_relative "modules"

class Knight < Piece
    include Steppable

    def initialize(color, board, position)
        super
        @symbol = (color == :white ? "♘" : "♞")
    end

    def move_diffs
        knight_moves
    end

    def symbol
        @symbol
    end
end