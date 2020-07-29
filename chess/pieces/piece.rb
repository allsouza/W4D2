

class Piece
    attr_reader :color, :board, :position

    def initialize(color, board, pos)
        @color = color
        @board = board
        @position = pos
    end

    def to_s
    
    end

    

    def inspect
        "class: #{self.class} symbol: #{symbol} position: #{@position} color: #{@color}  "
    end


end