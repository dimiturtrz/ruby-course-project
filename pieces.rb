require_relative "constants"
module Piece
  def initialize(starting_position, color, sign)
    @letter = starting_position.first # coordinates x
    @number = starting_position.last # coordinates y
    @color = color
    @moves = 0
    @sign = sign
  end

  def move(dest_letter, dest_number, move_pattern, limited, board)
    curr_column = LETTERS.index(@letter)
    dest_column = LETTERS.index(dest_letter)
    direction_check curr_column, dest_column, dest_number, move_pattern
    limits_check curr_column, dest_column, dest_number, limited
    obstructions_check curr_column, dest_column, dest_number, board
  end

  def direction_check(curr_column, dest_column, dest_number, move_pattern)
    straight = (curr_column == dest_column || @number == dest_number)
    diagonal = ((curr_column - dest_column).abs == (@number - dest_number).abs)
    return straight if move_pattern == :straight
    return diagonal if move_pattern == :diagonal
    return straight || diagonal if move_pattern == :both
  end

  def limits_check(curr_column, dest_column, dest_number, limited)
    letter_distance = (curr_column - dest_column).abs
    number_distance = (@number - dest_number).abs
    more_than_one_sqare = (letter_distance > 1) || (number_distance > 1)
    distance_limit_breached = more_than_one_sqare && limited
    !distance_limit_breached
  end

  def obstructions_check(curr_column, dest_column, dest_number, board)
    squares = get_squares_to_pass(curr_column, dest_column, dest_number)
    squares.each do |square|
      p board.get_square(square) if board.get_square(square).is_a? Piece
    end
    true
  end

  def get_squares_to_pass(curr_column, dest_column, dest_number)
    col_range = get_range(curr_column, dest_column)
    num_range = get_range(@number, dest_number)
    columns = col_range.size > 1 ? col_range.to_a : Array.new(num_range.size, curr_column)
    numbers = num_range.size > 1 ? num_range.to_a : Array.new(col_range.size, @number)
    letters = columns.map {|column| LETTERS[column]}
    [letters.drop(1), numbers.drop(1)].transpose
  end

  def get_range(curr, dest)
    curr > dest ? curr.downto(dest).to_a : (curr..dest).to_a
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
    super(dest_letter, dest_number, :straight, false, board)
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
