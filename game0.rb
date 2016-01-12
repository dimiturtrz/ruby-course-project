require_relative "errors_setup"
require_relative "console"

game = Console.new()

=begin
rook = Rook.new([:g, 4], :white)
rook.move([:g, 2], board)
rook.move([:g, 1], board)
rook.move([:f, 1], board)
rook.move([:f, 2], board)
rook.move([:f, 3], board)
board.refresh
=end
