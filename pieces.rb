require_relative "constants.rb"
module Piece
  def initialize(starting_position, color, sign)
    @letter = starting_position.first # coordinates x
    @number = starting_position.last #coordinates y
    @color = color
    @moves = 0
    @sign = sign
  end

  def move(dest_letter, dest_number, direction, limited)
    curr_column, dest_column = LETTERS.index @letter, LETTERS.index dest_letter
    direction_check curr_column, dest_column, dest_number, direction
    limits_check curr_column, dest_column, dest_number, limited
  end

  def direction_check(curr_column, dest_column, dest_number, direction)
    straight = (curr_column == dest_column || @number == dest_number)
    diagonal = ((curr_column - dest_column).abs == (@number - dest_number).abs)
    return straight if direction == :straight
    return diagonal if direction == :diagonal
    return straight || diagonal if direction == :both
  end

  def limits_check(curr_column, dest_letter, dest_number, limited)
    letter_distance = (curr_column - dest_column).abs
    number_distance = (@number - dest_number).abs
    more_than_one_sqare = (letter_distance > 1) || (number_distance > 1)
    distance_limit_breached = more_than_one_sqare && limited
    !distance_limit_breached
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

  def move(dest_letter, dest_number, board)
    
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
