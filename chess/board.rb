require_relative "./pieces/piece"
require_relative "./pieces/queen"
require_relative "./pieces/bishop"
require_relative "./pieces/rook"
require_relative "./pieces/knight"
require_relative "./pieces/king"
require_relative "./pieces/pawn"
require_relative "./pieces/null_piece"

class Board
    
    def initialize
        null_piece = NullPiece.instance
        @grid = Array.new(8) { Array.new(8) }
        (0...grid.length).each do |x|
            (0...grid.length).each do |y|
                if x >1 && x < 6
                    grid[x][y] = null_piece
                elsif x == 1 
                    grid[x][y] = Pawn.new(:white, self, [x,y])
                elsif x == 6
                    grid[x][y] = Pawn.new(:black, self, [x,y])
                elsif x == 7
                    case y
                    when 0, 7
                        grid[x][y] = Rook.new(:black, self, [x,y])
                    when 1, 6
                        grid[x][y] = Knight.new(:black, self, [x,y])
                    when 2, 5
                        grid[x][y] = Bishop.new(:black, self, [x,y])
                    when 3
                        grid[x][y] = Queen.new(:black, self, [x,y])
                    when 4
                        grid[x][y] = King.new(:black, self, [x,y])
                    end
                elsif x == 0
                    case y
                    when 0, 7
                        grid[x][y] = Rook.new(:white, self, [x,y])
                    when 1, 6
                        grid[x][y] = Knight.new(:white, self, [x,y])
                    when 2, 5
                        grid[x][y] = Bishop.new(:white, self, [x,y])
                    when 3
                        grid[x][y] = Queen.new(:white, self, [x,y])
                    when 4
                        grid[x][y] = King.new(:white, self, [x,y])
                    end
                end
            end
        end
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def []=(pos,val)
        x,y = pos
        @grid[x][y] = val
    end

    def valid_pos?(pos)
        (0..7).include?(pos[0]) && (0..7).include?(pos[1])
    end
    

    def move_piece(start_pos, end_pos)
        #swap the location of the pieces if null piece so that where we left from will now be a null piece. Or just make the start position a nullpiece reference after the move.
        # debugger
        piece = self[start_pos]
        if piece.moves.include?(end_pos)
            self[start_pos] = NullPiece.instance
            self[end_pos] = piece
            piece.position = end_pos
        else
            raise InvalidMove.new("Invalid move! end: #{end_pos} moves: #{piece.moves}")
        end
    end

    def in_check?(color)
        enemy_pcs = []
        king = nil
        @grid.each do |row|
            row.each do |piece|
                if piece.is_a?(King) && piece.color == color
                    king = piece
                elsif piece.color != color && !piece.is_a?(NullPiece)
                    enemy_pcs << piece
                end
            end
        end
        moves = []
        # debugger
        enemy_pcs.each do |piece| 
            moves += piece.moves
        end
        # debugger
        moves.any? { |move| move == king.position }
    end

    def checkmate?(color)
        #king can move out of the way
        my_pieces = []
        enemy_pcs = []
        king = nil
        @grid.each do |row|
            row.each do |piece|
                if piece.is_a?(King) && piece.color == color
                    king = piece
                elsif piece.color != color && !piece.is_a?(NullPiece)
                    enemy_pcs << piece
                elsif piece.color == color
                    my_pieces << piece
                end
            end
        end
        enemy_moves = []
        enemy_pcs.each do |piece| 
            enemy_moves += piece.moves
        end
        can_avoid = king.moves.any? do |move|
            !enemy_moves.include?(move)
        end
        return false if can_avoid
        #a piece can eat the checking piece
        my_moves = []
        my_pieces.each { |piece| my_moves += piece.moves }
      
        checking_king = enemy_pcs.map { |piece| piece.moves.include?(king.position) }
        can_kill = checking_king.all? do |piece| 
            my_moves.include?(piece.position)
        end
        return true if checking_king.count > 1
        return false if can_kill
        #i can block with a piece
        return true if checking_king[0].is_a?(Knight)
        in_between_positions
    end

    def in_between_positions(piece, king)
        k_pos = king.position
        p_pos = piece.position
        results = []
        case piece
        when Bishop
            total_diff = (k_pos[0] - p_pos[0]).abs
            diff_direction = diagonal_diff(p_pos, k_pos)
            i = 1
            total_diff.times do 
                new_x = i * diff_direction[0]
                new_y = i * diff_direction[1]
                results << [k_pos[0] + new_x, k_pos[1] + new_y]
                i += 1
            end
        when Rook
            diff_direction = orthogonal_diff(p_pos, k_pos)
            direction = diff_direction[2]
            i = 1
            total_diff = [k_pos[0]-p_pos[0], k_pos[1]-p_pos[1]]
            if direction == :x
                total_diff = (k_pos[0] - p_pos[0]).abs
            else
                total_diff = (k_pos[1] - p_pos[1]).abs
            end
            total_diff.times do 
                new_x = i * diff_direction[0]
                new_y = i * diff_direction[0]
                results << [k_pos[0] + new_x, k_pos[1] + new_y]
                i += 1
            end
        when Queen
        end
    end

    def diagonal_diff(p_pos, k_pos)
        if (k_pos[0] - p_pos[0]) > 0
            x_diff = 1
        else
            x_diff = -1
        end
        if (k_pos[1] - p_pos[1]) > 0
            y_diff = 1
        else
            y_diff = -1
        end
        return [x_diff, y_diff]
    end

    def orthogonal_diff(p_pos, k_pos)
        if k_pos[0] != p_pos[0]
            if k_pos[0] - p_pos[0] > 0
                return [1, 0, :x]
            else
                return [-1,0, :x]
            end
        else
            if k_pos[1] - p_pos[1] > 0
                return [0, 1, :y]
            else
                return [0,-1, :y]
            end
        end
    end
    attr_reader :grid
end

class InvalidMove < StandardError
end
# b = Board.new

# # piece = b[[7,1]]
# # # debugger
# # # p b[[4,4]] = piece
# # p piece.moves

# # # p b[[2,3]]
# # # b.move_piece([1,2],[2,3])
# # # p b[[1,2]]
# # # p b[[2,3]]