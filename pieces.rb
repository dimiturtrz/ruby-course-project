require_relative "constants.rb"
module Piece
  def initialize(starting_position, color, abbreviation)
    @x = starting_position.first
    @y = starting_position.last
    @color = color
    @moves = 0
    @abbreviation = abbreviation
  end
end

module PluralPiece
  include Piece
  def initialize(starting_position, color, piece_number, abbreviation)
    super starting_position, color, abbreviation
    @piece_number = piece_number
  end

  def to_s
    "#{@color[0].upcase}#{@abbreviation}#{@piece_number}"
  end
end

module SingularPiece
  include Piece
  def initialize(starting_position, color, abbreviation)
    super starting_position, color, abbreviation
  end

  def to_s
    "#{@color[0].upcase}#{@abbreviation} "
  end
end

class Pawn
  include PluralPiece
  def initialize(starting_position, color)
    pawn_number = (LETTERS.index starting_position.first) + 1
    super starting_position, color, pawn_number, "P"
  end

  def move(destination)
    
  end
end

class Rook
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[ROOK_INDENTATION]
    rook_number = starting_position.first == letter ? 1 : 2
    super starting_position, color, rook_number, "R"
  end

  def move

  end
end

class Knight
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[KNIGHT_INDENTATION]
    knight_number = starting_position.first == letter ? 1 : 2
    super starting_position, color, knight_number, "K"
  end

  def move

  end
end

class Bishop
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[BISHOP_INDENTATION]
    bishop_number = starting_position.first == letter ? 1 : 2
    super starting_position, color, bishop_number, "B"
  end

  def move

  end
end

class Queen
  include SingularPiece
  def initialize(starting_position, color)
    super starting_position, color, "Q"
  end

  def move

  end
end

class King
  include SingularPiece
  def initialize(starting_position, color)
    super starting_position, color, "K"
  end

  def move

  end
end
