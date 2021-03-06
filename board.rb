require_relative "constants"
require_relative "pieces"
class Board
  def initialize
    @board = Hash.new
    @pieces = Array.new
    place_player_pieces :white
    place_player_pieces :black
    refresh
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

  def get_square(coordinates)
    @board[coordinates.first][coordinates.last]
  end

  def first_possible_move color
    Error.disable_errors
    @pieces.find_all{ |piece| piece.color == color}.each do |piece|
      ('a'..'h').to_a.each do |letter|
        (1..8).to_a.each do |number|
          return if move(piece, [letter, number], color)
        end
      end
    end
    Error.enable_errors
  end

  def get_king(color)
    @pieces.find{|piece| piece.color == color && piece.kind_of?(King) }
  end

  def king_threatened?(color)
    get_king(color).threatened? self
  end

  def get_pieces
    @pieces
  end

  def get_living_pieces
    @pieces.reject{|piece| piece.taken?}
  end

  def find_piece piece_str, color
    found_piece = @pieces.find do |piece|
      piece.abbreviation == piece_str.upcase && piece.color == color
    end
    return found_piece ? found_piece : no_piece_error
  end

  def move piece_to_move, dest, color
    x, y = piece_to_move.letter, piece_to_move.number
    piece_to_move.move [dest[0].downcase.to_sym, dest[1].to_i - 1], self
  end

  def no_piece_error
    Error.raise_chess_error "can't touch this"
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

  def to_s
    string = ""
    @board.values.transpose.each_with_index do |row, index|
      string += "#{index+1}  #{row.map(&:to_s).join('│')}\n"
    end
    string += "#{' ' * (3 + 1)}#{LETTERS.map(&:upcase).join(' ' * 3)}\n"
  end

  #only for testing !!!
  def add_piece piece
    @pieces.push piece
    piece
  end
end
