require_relative "constants"
require_relative "piece_base"
class Pawn
  include PluralPiece
  def initialize(starting_position, color)
    pawn_number = (LETTERS.index starting_position.first) + 1
    sign = (color == :white ? '♙' : '♟')
    super starting_position, color, pawn_number, sign
  end

  def move(dest, board)
    return moving_back_error if moving_back?(dest.last)
    if destination_check LETTERS.index(@letter), LETTERS.index(dest.first),
                         dest.first, :diagonal
      final_square = can_move(dest.first, dest.last, :diagonal, true, board)
      return false unless final_piece
      return no_piece_error unless final_square.kind_of? Piece
      final_square.get_taken
    else
      return false unless can_move(dest.first, dest.last, :straight, true, board)
    end
    super dest
  end

  def moving_back?(dest_number)
    color == :white ? @number < dest_number : @number > dest_number
  end

  def moving_back_error
    p "pawns can't move backwards"
    false
  end

  def no_piece_error
    p "there ain't no piece there"
    false
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

  def move(dest, board)
    final_square = can_move dest.first, dest.last, :straight, false, board
    return false unless final_square
    final_square.get_taken if final_square.kind_of? Piece
    super dest
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

  def move(dest, board)
    final_square = can_move dest.first, dest.last, :diagonal, false, board
    return false unless final_square
    final_square.get_taken if final_square.kind_of? Piece
    super dest
  end
end

class Queen
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :white ? '♕' : '♛')
    super starting_position, color, sign
  end

  def move(dest, board)
    final_square = can_move dest.first, dest.last, :both, false, board
    return false unless final_square
    final_square.get_taken if final_square.kind_of? Piece
    super dest
  end
end

class King
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :white ? '♔' : '♚')
    super starting_position, color, sign
  end

  def move(dest, board)
    final_square = can_move dest.first, dest.last, :both, true, board
    return false unless final_square
    final_square.get_taken if final_square.kind_of? Piece
    super dest
  end
end
