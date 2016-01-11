require_relative "board"

board = Board.new()
rook = Rook.new([:g, 2], :white)
rook.move([:g, 1], board)
rook.move([:g, 0], board)
rook.move([:f, 0], board)
rook.move([:f, 1], board)
rook.move([:f, 2], board)
board.refresh
board.print
