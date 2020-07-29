

class Piece
    attr_accessor :color, :board, :position

    def initialize(color, board, pos)
        @color = color
        @board = board
        @position = pos
        @symbol = " "
    end

    def to_s
        @symbol
    end

    

    def inspect
        "class: #{self.class} symbol: #{symbol} position: #{@position} color: #{@color}  "
    end


end