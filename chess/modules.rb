require 'byebug'

module Slideable

    HORIZONTAL_DIRS = [[0,-1], [-1,0], [1,0], [0,1]]
    DIAGONAL_DIRS = [[1,1], [1,-1], [-1,-1], [-1,1]]
#move_dirs passes the direction from the subclass

    def moves
        results = []
        move_dirs.each do |direction|
            x,y = direction
            results += grow_unblocked_moves_in_dir(x,y)
        end
        results
    end

    def horizontal_dirs
        HORIZONTAL_DIRS 
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def grow_unblocked_moves_in_dir(dx,dy)
        result = []
        finished = false
        new_x = position[0]
        new_y = position[1]
        until finished 
            new_x += dx
            new_y += dy
            new_pos = [new_x, new_y]
            break if !board[new_pos].nil? || !(0..7).include?(new_y) || !(0..7).include?(new_x)
            result << new_pos
        end
        return result
    end
end

module Steppable
    KNIGHT_MOVES = [[1,2],[2,1],[-1,-2],[-2,-1],[-1,2],[2,-1],[1,-2],[-2,1]]
    KING_MOVES = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]

    def moves
        results = []
        x,y = position
        move_diffs.each do |directions|
            results += [[directions[0]+x, directions[1] + y]]
        end
        # debugger
        results.reject {|pos| !board[pos].nil? || !(0..7).include?(pos[1]) || !(0..7).include?(pos[0]) }
    end

    def king_moves
        KING_MOVES
    end

    def knight_moves
        KNIGHT_MOVES
    end
end


