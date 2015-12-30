require_relative "constants.rb"
module Piece
  def initialize(starting_position, color, sign)
    @x = starting_position.first
    @y = starting_position.last
    @color = color
    @moves = 0
    @sign = sign
  end
end

module PluralPiece
  include Piece
  def initialize(starting_position, color, piece_number, sign)
    super starting_position, color, sign
    @piece_number = piece_number
  end

  def to_s
    "#{@sign} #{@piece_number}"
  end
end

module SingularPiece
  include Piece
  def initialize(starting_position, color, sign)
    super starting_position, color, sign
  end

  def to_s
    " #{@sign} "
  end
end

class Pawn
  include PluralPiece
  def initialize(starting_position, color)
    pawn_number = (LETTERS.index starting_position.first) + 1
    sign = (color == :white ? '♙' : '♟')
    super starting_position, color, pawn_number, sign
  end

  def move(destination)
    
  end
end

class Rook
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[ROOK_INDENTATION]
    rook_number = starting_position.first == letter ? 1 : 2
    sign = (color == :white ? '♖' : '♜')
    super starting_position, color, rook_number, sign
  end

  def move

  end
end

class Knight
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[KNIGHT_INDENTATION]
    knight_number = starting_position.first == letter ? 1 : 2
    sign = (color == :white ? '♘' : '♞')
    super starting_position, color, knight_number, sign
  end

  def move

  end
end

class Bishop
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[BISHOP_INDENTATION]
    bishop_number = starting_position.first == letter ? 1 : 2
    sign = (color == :white ? '♗' : '♝')
    super starting_position, color, bishop_number, sign
  end

  def move

  end
end

class Queen
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :white ? '♕' : '♛')
    super starting_position, color, sign
  end

  def move

  end
end

class King
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :white ? '♔' : '♚')
    super starting_position, color, sign
  end

  def move

  end
end
