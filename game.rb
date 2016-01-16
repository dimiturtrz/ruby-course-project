require_relative "board"
require_relative "console"
require_relative "graphical"

class Game
  def initialize
    @turns = 0
    @board = Board.new
    @color = :white
    @game_over = false
    init_mode
  end

  def init_mode
    puts "choose the mode you most desire by typing it's corresponding number"
    MODES.each_with_index{|mode, index| puts "#{index + 1}\t#{mode}" }
    loop do
      begin
        get_mode Integer(gets.chomp)
        break;
      rescue ArgumentError
        puts "numbers **********, do you speak it?!"
      end
    end
  end

  def get_mode(mode_number)
    case mode_number
      when 1 then self.class.send(:include, Console)
      when 2 then self.class.send(:include, Graphical)
    end
  end

  def start
    game_loop
  end

  def game_loop
    until @game_over do
      begin
        player_turn
        @turns += 1
      rescue ChessError => error
        visualize_error error.message
      end
    end
    visualize_winner @color
  end

  def player_turn
    begin
      board_backup = Marshal.load(Marshal.dump @board)      
      visualize_state @turns, @color, @board
      input_valid = parse_input
      break if @game_over
      @board.refresh
      input_valid = handle_check input_valid, board_backup
    end until input_valid
    @color = (@color == :white ? :black : :white)
  end

  def handle_check(input_valid, board_backup)
    if input_valid && @board.king_threatened?(@color)
      @board = board_backup
      p "defend king"
      return false
    end
    input_valid
  end

  def parse_input
    input = interface_get_input
    case input.first
      when :move then handle_move *input.drop(1)
      when :surrender then handle_surrender
      when :save then save_to_file
      when :load then load_from_file
      when :unrecognized then Error.raise_chess_error "unrecognized command"
    end
  end

  def handle_move(piece, dest)
    @board.move piece, dest, @color
  end

  def handle_surrender
    @game_over = true
  end

  def save_to_file
    data = [@board, @turns, @color]
    File.open("save", 'w') { |file| file.write Marshal.dump data }
    false
  end

  def load_from_file
    @board, @turns, @color = Marshal.load(File.binread("save"))
    false
  end
end
