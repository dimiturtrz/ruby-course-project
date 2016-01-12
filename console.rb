require_relative "board"

class Console
  def initialize
    @turns = 0
    @board = Board.new
    game_loop
  end

  def game_loop
    loop do
      @board.print
      parse_input get_input
    end
  end

  def get_input
    gets.chomp
  end

  def parse_input(input)
    case input
      when /^move/ then handle_move input
    end
  end

  def handle_move input
    piece, dest = input.split(/\s/).drop(1)
    return out_of_field_error unless dest =~ /[a-hA-H][1-8]/
    @board.move piece, dest
  end

  def out_of_field_error
    p "try not to think out of that particular box"
    false
  end
end
