require_relative "modules"

class Queen < Piece
    include Slideable

    def initialize(color, board, position)
        super
        @symbol = (color == :white ? "♕" : "♛")
    end

    def symbol
        @symbol
    end

    def move_dirs
        diagonal_dirs + horizontal_dirs
    end

end