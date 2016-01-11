require_relative "constants"
module Piece
  def initialize(starting_position, color, sign)
    @letter = starting_position.first # coordinates x
    @number = starting_position.last # coordinates y
    @color = color
    @moves = 0
    @sign = sign
    @taken = false
  end

  def can_move(dest_letter, dest_number, move_pattern, limited, board)
    curr_column = LETTERS.index(@letter)
    dest_column = LETTERS.index(dest_letter)
    unless direction_check curr_column, dest_column, dest_number, move_pattern
      return direction_error 
    end
    unless limits_check curr_column, dest_column, dest_number, limited
      return limits_error
    end
    return obstructions_check curr_column, dest_column, dest_number, board
  end

  def direction_check(curr_column, dest_column, dest_number, move_pattern)
    straight = (curr_column == dest_column || @number == dest_number)
    diagonal = ((curr_column - dest_column).abs == (@number - dest_number).abs)
    case move_pattern
      when :straight then straight
      when :diagonal then diagonal 
      when :both then straight || diagonal
    end
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
    last_square = squares.pop
    squares.each do |square|
      return obstruction_error if board.get_square(square).is_a? Piece
    end
    board.get_square last_square
  end

  def get_squares_to_pass(curr_column, dest_column, dest_number)
    col_range = get_range(curr_column, dest_column)
    num_range = get_range(@number, dest_number)
    columns = col_range.size > 1 ? col_range.to_a : Array.new(num_range.size, curr_column)
    numbers = num_range.size > 1 ? num_range.to_a : Array.new(col_range.size, @number)
    letters = columns.map {|column| LETTERS[column]}
    [letters.drop(1), numbers.drop(1)].transpose
  end

  def direction_error
    p "wrong direction. ye drunk?"
    false
  end

  def limits_error
    p "that's it, you've crossed the line"
    false
  end

  def obstruction_error
    p "nuh-uh theres a bloke in the way"
    false
  end

  def get_range(curr, dest)
    curr > dest ? curr.downto(dest).to_a : (curr..dest).to_a
  end

  def move(destination)
    @letter = destination.first
    @number = destination.last
  end

  def get_taken
    @taken = true
  end

  def letter
    @letter
  end

  def number
    @number
  end

  def taken?
    @taken
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
