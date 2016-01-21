module Console
  def visualize_state(turns, color, board)
    visualize_turn_info turns, color, board
    visualize_board board
  end

  def visualize_turn_info(turns, color, board)
    puts "-------------------------------------------------"
    puts "turn #{turns}"
    puts color
    puts "#{color.to_s} king threatened" if board.king_threatened?(color)
  end

  def visualize_board(board)
    puts board
  end

  def visualize_winner(color)
    puts "Congrats #{@color.to_s} wins!!!"
  end

  def visualize_error(message)
    puts "!!!\nERROR: #{message}\n!!!"
  end

  def interface_get_input board, color
    input = gets.chomp
    case input
      when /^move/ then parse_move_input input, board, color
      when /^surrender/ then [:surrender]
      when /^save/ then [:save]
      when /^load/ then [:load]
    else
      [:unrecognized]
    end
  end

  def parse_move_input(input, board, color)
    piece_str, dest = input.split(/\s/).drop(1)
    return out_of_field_error unless dest =~ /[a-hA-H][1-8]/
    piece = board.find_piece piece_str, color
    [:move, piece, dest]
  end

  def init_interface
  end

  def out_of_field_error
    Error.raise_chess_error "try not to think out of that particular box"
  end
end
