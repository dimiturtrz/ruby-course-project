require_relative "constants"
require_relative "piece_base"
class Pawn
  include PluralPiece
  def initialize(starting_position, color)
    pawn_number = (LETTERS.index starting_position.first) + 1
    sign = (color == :black ? '♙' : '♟')
    super starting_position, color, pawn_number, sign, "P#{pawn_number}"
  end

  def can_move(dest, board)
    return moving_back_error if moving_back?(dest.last)
    column, dest_column = LETTERS.index(@letter), LETTERS.index(dest.first)
    if direction_check column, dest_column, dest.last, :diagonal
      final_square = super dest.first, dest.last, :diagonal, true, board
      return diagonal_move dest, board, final_square
    else
      return true if first_turn_movement dest, board
      super(dest.first, dest.last, :straight, true, board).to_s == " " * 3
    end
  end

  def diagonal_move(dest, board, final_square)
    return false unless final_square
    return no_piece_error unless final_square.kind_of? Piece
    final_square.get_taken_by self
    true
  end

  def first_turn_movement(dest, board)
    first_move = moves == 0
    same_column = dest.first == @letter
    two_numbers_forth = (dest.last - @number).abs == 2
    first_turn_movement = first_move && same_column && two_numbers_forth
    dest_unoccupied = board.get_square(dest) == " " * 3
    first_turn_movement && dest_unoccupied
  end

  def move(dest, board)
    super dest if can_move dest, board
  end

  def moving_back?(dest_number)
    @color == :black ? @number <= dest_number : @number >= dest_number
  end

  def moving_back_error
    p "no moonwalking for pawns!" if $errors_enabled
    false
  end

  def no_piece_error
    p "there ain't no piece there" if $errors_enabled
    false
  end
end

class Rook
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[ROOK_INDENTATION]
    rook_number = starting_position.first == letter ? 1 : 2
    sign = (color == :black ? '♖' : '♜')
    super starting_position, color, rook_number, sign, "R#{rook_number}"
  end

  def can_move(dest, board)
    super dest.first, dest.last, :straight, false, board
  end

  def move(dest, board)
    final_square = can_move dest, board
    return false unless final_square
    final_square.get_taken_by self if final_square.kind_of? Piece
    super dest
  end
end

class Knight
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[KNIGHT_INDENTATION]
    knight_number = starting_position.first == letter ? 1 : 2
    sign = (color == :black ? '♘' : '♞')
    super starting_position, color, knight_number, sign, "H#{knight_number}"
  end

  def can_move dest, board
    dest_letter, dest_number = dest
    vertical = (LETTERS.index(@letter) - LETTERS.index(dest_letter)).abs 
    horizontal = (dest_number - @number).abs
    (horizontal == 1 && vertical == 2) || (horizontal == 2 && vertical == 1)
  end

  def move(dest, board)
    return knight_error unless can_move dest, board
    final_square = board.get_square dest
    final_square.get_taken_by self if final_square.kind_of? Piece
    super dest
  end

  def knight_error
    p "can't expect all horses to move like the Jagger"  if $errors_enabled
    false
  end
end

class Bishop
  include PluralPiece
  def initialize(starting_position, color)
    letter = LETTERS[BISHOP_INDENTATION]
    bishop_number = starting_position.first == letter ? 1 : 2
    sign = (color == :black ? '♗' : '♝')
    super starting_position, color, bishop_number, sign, "B#{bishop_number}"
  end

  def can_move(dest, board)
    super dest.first, dest.last, :diagonal, false, board
  end

  def move(dest, board)
    final_square = can_move dest, board
    return false unless final_square
    puts "here"
    final_square.get_taken_by self if final_square.kind_of? Piece
    super dest
  end
end

class Queen
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :black ? '♕' : '♛')
    super starting_position, color, sign, "Q"
  end

  def can_move(dest, board)
    super dest.first, dest.last, :both, false, board
  end

  def move(dest, board)
    final_square = can_move dest, board
    return false unless final_square
    final_square.get_taken_by self if final_square.kind_of? Piece
    super dest
  end
end

class King
  include SingularPiece
  def initialize(starting_position, color)
    sign = (color == :black ? '♔' : '♚')
    super starting_position, color, sign, "K"
  end

  def can_move(dest, board)
    super dest.first, dest.last, :both, true, board
  end

  def move(dest, board)
    final_square = can_move dest, board
    return false unless final_square
    final_square.get_taken_by self if final_square.kind_of? Piece
    super dest
  end

  def threatened?(board)
    pieces = board.get_pieces.reject do |piece|
      piece.color == @color || piece.taken?
    end
    disable_errors
    threats = pieces.find{ |piece| piece.can_move([@letter, @number], board) }
    enable_errors
    !threats.nil?
  end
end
