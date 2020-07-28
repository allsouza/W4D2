require_relative "piece"
require_relative "queen"
require_relative "bishop"
require_relative "rook"
require_relative "knight"
require_relative "king"
require_relative "pawn"
require_relative "null_piece"

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
        grid[x][y]
    end

    def []=(pos,val)
        x,y = pos
        grid[x][y] = val
    end
    

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        self[start_pos] = nil
        self[end_pos] = piece
    end

    private
    attr_reader :grid

end

b = Board.new
# p b
piece = Pawn.new(:white, b, [4,4])
p b[[4,4]] = piece
p piece.moves

# p b[[2,3]]
# b.move_piece([1,2],[2,3])
# p b[[1,2]]
# p b[[2,3]]