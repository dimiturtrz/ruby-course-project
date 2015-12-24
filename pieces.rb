require_relative "constants.rb"
module Piece
  def initialize(starting_position, color)
    @x = starting_position.first
    @y = starting_position.last
    @color = color
    @moves = 0
  end
end

class Pawn
  include Piece
  def initialize(starting_position, color)
    super starting_position, color
    @pawn_number = LETTERS.index starting_position.first + 1
  end

  def move(destination)
    
  end
end

class Rook
  include Piece
  def initialize(starting_position, color)
    super starting_position, color
    @rook_number = starting_position.first == LETTERS.first ? 1 : 2
  end

  def move

  end
end
