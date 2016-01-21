require_relative 'graph_board'

module Graphical
  def init_interface
    @@game = GameWindow.new
    @@game.show
  end

  def visualize_state (turns, color, board)
  end

  def interface_get_input(board, color)
    gets.chomp
  end
end
