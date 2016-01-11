require_relative "constants"
require_relative "pieces"
class Board
  def initialize()
    @board = Hash.new
    @pieces = Array.new
    place_player_pieces :white
    place_player_pieces :black
    refresh
  end

  def get_square(coordinates)
    @board[coordinates.first][coordinates.last]
  end

  def place_player_pieces(color)
    place_player_pawns color
    place_player_rooks color
    place_player_knights color
    place_player_bishops color
    place_player_queen color
    place_player_king color
  end

  def place_player_pawns(color)
    LETTERS.each do |letter|
      number = (color == :white ? PAWNS_ROW - 1 : NUMBERS.size - PAWNS_ROW)
      @pieces.push Pawn.new([letter, number], color)
    end
  end

  def place_player_rooks(color)
    place_player_elites(color, "rook")
  end

  def place_player_knights(color)
    place_player_elites(color, "knight")
  end

  def place_player_bishops(color)
    place_player_elites(color, "bishop")
  end

  def place_player_elites(color, elite_name)
    number = (color == :white ? ELITES_ROW - 1 : NUMBERS.size - ELITES_ROW)
    elite_class = eval("#{elite_name}".capitalize)
    elite_indentation = eval("#{elite_name}_indentation".upcase)
    letter = LETTERS[elite_indentation]
    @pieces.push elite_class.new([letter, number], color)
    letter = LETTERS[-elite_indentation - 1]
    @pieces.push elite_class.new([letter, number], color)
  end

  def place_player_queen(color)
    letter = LETTERS[color == :white ? QUEEN_INDENTATION : KING_INDENTATION]
    number = (color == :white ? ELITES_ROW - 1 : NUMBERS.size - ELITES_ROW)
    @pieces.push Queen.new([letter, number], color)
  end

  def place_player_king(color)
    letter = LETTERS[color == :white ? KING_INDENTATION : QUEEN_INDENTATION]
    number = (color == :white ? ELITES_ROW - 1 : NUMBERS.size - ELITES_ROW)
    @pieces.push King.new([letter, number], color)
  end

  def refresh
    clear
    @pieces.each do |piece|
      @board[piece.letter][piece.number] = piece unless piece.taken?
    end
  end

  def clear
    LETTERS.each{ |letter| @board[letter] = Array.new(NUMBERS.size, " " * 3)}
  end

  def print()
    @board.values.transpose.each_with_index do |row, index|
      puts "#{index+1}  #{row.map(&:to_s).join('│')}"
    end
    puts "#{' ' * (3 + 1)}#{LETTERS.map(&:upcase).join(' ' * 3)}"
  end
end
