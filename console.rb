require_relative "board"

class Console
  def initialize
    @turns = 0
    @board = Board.new
    @color = :white
    @game_over = false
  end

  def start
    game_loop
  end

  def game_loop
    until @game_over do
      player_turn
      @turns += 1
    end
    puts "Congrats #{@color.to_s} wins!!!"
  end

  def print_turn_info
    puts "-------------------------------------------------"
    puts "turn #{@turns}"
    puts @color
    puts "#{@color.to_s} king threatened" if @board.king_threatened?(@color)
  end

  def player_turn
    begin
      board_backup = Marshal.load(Marshal.dump @board)      
      print_turn_info
      @board.print
      input_valid = parse_input gets.chomp
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

  def parse_input(input)
    case input
      when /^move/ then handle_move input
      when /^surrender/ then handle_surrender
      when /^save/ then save_to_file
      when /^load/ then load_from_file
    end
  end

  def handle_move(input)
    piece, dest = input.split(/\s/).drop(1)
    return out_of_field_error unless dest =~ /[a-hA-H][1-8]/
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

  def out_of_field_error
    p "try not to think out of that particular box" if $errors_enabled
    false
  end
end
