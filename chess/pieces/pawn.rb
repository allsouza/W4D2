require 'byebug'

class Pawn < Piece
    def initialize(color, board, pos)
        super
        @symbol = (color == :white ? "♙" : "♟︎")
    end

    def symbol
        @symbol
    end

    def moves
        # debugger
        x,y = position
        result = forward_steps + side_attacks
        result.map {|change| [x+change[0], y+ change[1]] }
    end

    def forward_dir
        self.color == :black ? -1 : 1
    end

    def forward_steps #1 or 2 moves
        result = [[forward_dir,0]]
        result << [forward_dir*2,0] if position[0] == 6 || position[0] == 1
        result
    end

    def side_attacks
        results = []
        right_attack = [forward_dir,1]
        left_attack = [forward_dir, -1]
        x,y = position
        left_new = [x+left_attack[0], y+left_attack[1]]
        right_new = [x+right_attack[0], y+right_attack[1]]

        if !board[left_new].is_a?(NullPiece) #check for different color
            results << right_attack
        elsif !board[right_new].is_a?(NullPiece)
            results << left_attack
        end
        results
    end
end