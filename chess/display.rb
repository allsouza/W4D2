require_relative "board"
require_relative "cursor"
require "colorize"
require 'byebug'

class Display
    attr_reader :board, :cursor
    
    def initialize (board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        system "clear"
        grid = self.board.grid
        # debugger
        (0..7).each do |row|
            (0..7).each do |column|
                if [row, column] == @cursor.cursor_pos
                    print "#{grid[row][column].symbol.colorize(cursor.color)} "
                else
                    print "#{grid[row][column]} "
                end
            end
            puts
        end
    end

    def render_loop
        positions = []
        while true
            self.render
            result = @cursor.get_input
            if @cursor.selected && positions.count == 0
                positions << result
            elsif !@cursor.selected && positions.count == 1
                positions << result
                board.move_piece(positions[0], positions[1])
                positions = []
            end
        end
    end

end

b1 = Board.new
d = Display.new(b1)
d.render_loop
# p b1[[0,3]] = Rook.new(:black, b1, [0,3])
# p b1[[1,3]] = Bishop.new(:black, b1, [1,3])
# p b1[[1,4]] = Rook.new(:black, b1, [1,4])
# p b1[[1,5]] = Bishop.new(:black, b1, [1,5])
# p b1[[0,5]] = Rook.new(:black, b1, [0,5])
# p b1[[3,5]] = Knight.new(:black, b1, [3,5])
# d.render
# p b1.in_check?(:white)
# p b1.checkmate?(:white)

