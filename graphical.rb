require_relative 'graph_board'

Thread.abort_on_exception=true
module Graphical
  def init_interface(board)
    @@game = GameWindow.new board
    @@game_thread = Thread.new do
      @@game.show
    end

    @@pending_input = false
    @@output = nil
  end

  def visualize_state(turns, color, board)
  end

  def self.visualize_error(message)
    puts message
  end

  def visualize_error(message)
    puts message
  end

  def self.return_input(input)
    @@pending_input = true
    @@output = input
  end

  def interface_get_input(board, color)
    @@color = color
    loop { break if @@pending_input }
    @@pending_input = false
    @@output
  end

  def self.get_color
    @@color
  end
end
