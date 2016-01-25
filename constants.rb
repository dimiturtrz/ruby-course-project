LETTERS = [:a, :b, :c, :d, :e, :f, :g, :h] #columns
NUMBERS = (1..8).to_a #rows
COLORS = [:white, :black]
# all pieces
PIECES = ["pawn", "rook", "knight", "bishop", "queen", "king"]
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
# interfaces
INTERFACES = [:console, :graphical]
# players
PLAYERS = [:vscomputer, :vsplayer]
# dimenstions
DIMENSIONS = { height: 480, width: 640}

BOARD_X_OFFSET = DIMENSIONS[:width]/12
BOARD_Y_OFFSET = DIMENSIONS[:height]/12

BUTTON_X_OFFSET = DIMENSIONS[:width]/5
BUTTON_Y_OFFSET = DIMENSIONS[:height]/20

COORDS_FONT_SIZE = 40
BUTTONS_FONT_SIZE = 20
