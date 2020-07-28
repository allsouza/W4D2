class Pawn < Piece
    def initialize(color, board, pos)
        super
        @symbol = (color == :white ? "♙" : "♟︎")
    end

    def symbol
        @symbol
    end

    def moves
        result = forward_steps + side_attacks
    end

    def forward_dir
        self.color == :black ? -1 : 1
    end

    def forward_steps #1 or 2 moves
        result = [[0,forward_dir]]
        result << [0,forward_dir*2] if position[0] == 6 || position[0] == 2
        result
    end

    def side_attacks
        results = []
        right_attack = [1,forward_dir]
        left_attack = [-1, forward_dir]
        x,y = position
        left_new = [x+left_attack[0], y+left_attack[1]]
        right_new = [x+right_attack[0], y+right_attack[1]]

        if !board[left_new].is_a?(NullPiece)
            results << right_attack
        elsif !board[right_new].is_a?(NullPiece)
            results << left_attack
        end
        results
    end
end