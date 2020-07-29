require 'singleton'
require 'colorize'

class NullPiece < Piece
    include Singleton

    def initialize
        @symbol = "■".colorize(:light_black)
    end

    def moves
        []
    end
    
    def symbol
        @symbol
    end

end