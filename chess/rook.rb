require_relative "modules"

class Rook < Piece
    include Slideable

    def initialize(color, board, pos)
        super
        @symbol = (color == :white ? "♖" : "♜")
    end

    def symbol
        @symbol
    end

    def move_dirs
        horizontal_dirs
    end

end