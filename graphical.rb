require_relative 'graph_board'

module Graphical
  def init_interface(board)
    @@game = GameWindow.new board
    @@game.show
  end

  def visualize_state(turns, color, board)
  end

  def interface_get_input(board, color)
    gets.chomp
  end
end
