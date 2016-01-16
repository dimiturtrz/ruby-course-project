LETTERS = [:a, :b, :c, :d, :e, :f, :g, :h] #columns
NUMBERS = (1..8).to_a #rows
COLORS = [:white, :black]
# elites
ELITES = ["rook", "knight", "bishop"]
# on which row figures are
PAWNS_ROW = 2
ELITES_ROW = 1
# how much inside their row are the elites
ROOK_INDENTATION = 0
KNIGHT_INDENTATION = 1
BISHOP_INDENTATION = 2
QUEEN_INDENTATION = 3
KING_INDENTATION = 4
# how can pieces move
DIRECTIONS = [:diagonal, :straight, :both]
MOVEMENT_LIMITS = [true, false] # true = 1, false = no limits
# game allowed methods
GAME_METHODS = [:move, :save, :load, :surrender]
# modes
MODES = [:console, :graphical]
