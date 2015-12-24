require_relative "constants"
class Board
  def initialize()
    @board = Array.new(LETTERS.size){Array.new(NUMBERS.size)}
    place_player_pieces :white
  end

  def place_player_pieces(color)
    place_player_pawns color
    place_player_rooks color
    place_player_knights color
    place_player_bishops color
  end

  def place_player_pawns(color)
    LETTERS.each do |letter|
      number = (color == :white ? PAWNS_ROW : NUMBERS.size - PAWNS_ROW + 1)
      @board[letter][number] = Pawn.new([letter, number], color)
    end
  end

  def place_player_rooks(color)
    number = (color == :white ? ELITES_ROW : NUMBERS.size - ELITES_ROW + 1)
    @board[LETTERS.first][number] = Rook.new([LETTERS.first, number], color)
    @board[LETTERS.last][number] = Rook.new([LETTERS.last, number], color)
  end

  def print()
    @board.each {|row| p row}
  end
end
