require_relative "board"
require_relative "console"
require_relative "graphical"

class Game
  def initialize
    @turns = 0
    @board = Board.new
    @color = :white
    @game_over = false
    choose_interface
    choose_players
    init_interface @board
  end

  def choose_interface
    case get_mode(INTERFACES)
      when 1 then self.class.send(:include, Console)
      when 2 then self.class.send(:include, Graphical)
    end
  end

  def choose_players
    case get_mode(PLAYERS)
      when 1 then @singleplayer = true
      when 2 then @singleplayer = false
    end
  end

  def get_mode mode_type
    puts "choose the mode you most desire by typing it's corresponding number"
    mode_type.each_with_index{ |mode, index| puts "#{index + 1}\t#{mode}" }
    loop do
      begin
        return Integer(gets.chomp)
      rescue ArgumentError
        puts "numbers **********, do you speak it?!"
      end
    end
  end

  def reversed_color
    @color == :white ? :black : :white
  end

  def start
    game_loop
  end

  def game_loop
    until @game_over do
      begin
        @singleplayer ? one_player_turn : two_player_turn
      rescue ChessError => error
        visualize_error error.message
      end
    end
    visualize_winner @color
  end

  def two_player_turn
    player_turn
    @color = reversed_color
    @turns += 1
  end

  def one_player_turn
    @turns.even? ? player_turn : computer_turn
    @turns += 1
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
    @board.refresh
  end

  def computer_turn
    computer_color = reversed_color
    visualize_state @turns, @color, @board
    if @board.king_threatened?(computer_color)
      @color = reversed_color
      handle_surrender
    end
    @board.first_possible_move computer_color
    @board.refresh
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
    input = interface_get_input @board, @color
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
    @color = reversed_color
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
