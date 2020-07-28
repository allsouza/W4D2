require_relative "modules"

class King < Piece
    include Steppable

    def initialize(color, board, position)
        super
        @symbol = (color == :white ? "♔" : "♚")
    end

    def move_diffs
        king_moves
    end

    def symbol
        @symbol
    end
end
