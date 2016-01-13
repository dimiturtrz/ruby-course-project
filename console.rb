require_relative "board"

class Console
  def initialize
    @turns = 0
    @board = Board.new
    @game_over = false
    game_loop
  end

  def game_loop
    until @game_over do
      player_turn :white
      player_turn :black
      @turns += 1
    end
  end

  def print_turn_info(color)
    puts "-------------------------------------------------"
    puts "turn #{@turns}"
    puts color
    puts "#{color.to_s} king threatened" if @board.king_threatened?(color)
  end

  def player_turn(color)
    begin
      @board.refresh
      print_turn_info color
      @board.print
      input_valid = parse_input gets.chomp, color
      input_valid = handle_check input_valid, color
    end until input_valid
  end

  def handle_check(input_valid, color)
    if input_valid && @board.king_threatened?(color)
      input_valid.reverse_move
      p "defend king"
      return false
    end
    input_valid
  end

  def parse_input(input, color)
    case input
      when /^move/ then handle_move input, color
      when /^surrender/ then handle_surrender
    end
  end

  def handle_move(input, color)
    piece, dest = input.split(/\s/).drop(1)
    return out_of_field_error unless dest =~ /[a-hA-H][1-8]/
    @board.move piece, dest, color
  end

  def handle_surrender
    @game_over = true
  end

  def out_of_field_error
    p "try not to think out of that particular box" if $errors_enabled
    false
  end
end
