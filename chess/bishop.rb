require_relative "modules"

class Bishop < Piece
    include Slideable

    def initialize(color, board, pos)
        super
        @symbol = (color == :white ? "♗" : "♝")
    end

    def symbol
        @symbol
    end

    def move_dirs
        diagonal_dirs
    end

end