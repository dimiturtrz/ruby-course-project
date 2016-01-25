require_relative 'constants'
require_relative 'graphical'
require 'gosu'
include Gosu

class GameWindow < Window
  def initialize board
    super DIMENSIONS[:width], DIMENSIONS[:height]
    self.caption = "Gosu Chess"

    @board = board
    get_piece_icons
    @held_piece = false
  end

  def needs_cursor?
    true
  end

  def draw
    dye_background Color::BLUE
    draw_board
    draw_pieces
    draw_buttons
  end
	
  def update
  end

  def swap_board(board)
    @board = board
  end

  def button_down(id)
    case id
      when Gosu::MsLeft then init_handle_click
    end
  end

  def init_handle_click
    begin
      if handle_click
        Graphical.return_input handle_click
        @held_piece = false
      end
    rescue ChessError => error
      Graphical.visualize_error error.message
    end
  end

  def handle_click
    return handle_board_click if mouse_in_board?
    return handle_button_click if mouse_on_button?
  end

  def handle_board_click
    unless @held_piece
      @held_piece = grab_piece
      false
    else
      [:move, @held_piece, coordinates_to_index(mouse_x, mouse_y)]
    end
  end

  def handle_button_click
    case (mouse_x/BUTTON_X_OFFSET).floor
      when 1 then [:save]
      when 2 then [:load]
      when 3 then [:surrender]
    end
  end

  def grab_piece
    letter, number = coordinates_to_index(mouse_x, mouse_y)
    piece = @board.get_square [letter, number-1]
    return not_a_piece_error unless piece.kind_of? Piece
    return wrong_square_error unless piece.color == Graphical.get_color
    piece
  end

  def not_a_piece_error
    Error.raise_chess_error "pick a piece or get lost"
  end

  def wrong_square_error
    Error.raise_chess_error "you can only move your pieces"
  end

  def draw_pieces
    @board.get_living_pieces.each do |piece|
      piece_icon = @piece_icons[get_piece_sym(piece)]
      x, y = index_to_coordinates piece.letter, piece.number
      piece_icon.draw x, y ,0
    end
  end

  def draw_board
    start_x, start_y = BOARD_X_OFFSET, BOARD_Y_OFFSET
    end_y = nil
    (1..8).each do |row|
      y = start_y + (row * BOARD_Y_OFFSET)
      draw_text start_x, y, row, 40
      (1..8).each do |cell|
        x = start_x + (cell * BOARD_X_OFFSET)
        col = (row + cell).even? ? Color::BLACK : Color::WHITE
        draw_rect x, y, BOARD_X_OFFSET, BOARD_Y_OFFSET, col
      end
    end_y = y + BOARD_X_OFFSET
    end
    8.times do |number|
      letter_x = number + 1.25
      draw_text start_x + (letter_x * BOARD_X_OFFSET), end_y, LETTERS[number], 40
    end
  end

  def draw_buttons
    texts = ["save", "load", "surrender"]
    3.times do |time|
      begining = [(time + 1) * BUTTON_X_OFFSET, BUTTON_Y_OFFSET]
      ending = [BUTTON_X_OFFSET - 1, BUTTON_Y_OFFSET]
      draw_rect *begining, *ending, Color::GREEN
      draw_text *begining, texts[time], BUTTONS_FONT_SIZE
    end
  end

  def get_piece_icons
    @piece_icons = Hash.new
    COLORS.each do |color|
      PIECES.each do |piece|
        piece_str = "#{color}_#{piece}".to_sym
        piece_path = "icons/pieces/#{piece_str}.png"
        @piece_icons[piece_str] = Gosu::Image.new self, piece_path, true
      end
    end
  end

  def get_piece_sym(piece)
    rank = piece.class.to_s.downcase.to_sym
    color = piece.color.to_s
    "#{color}_#{rank}".to_sym
  end

  def mouse_in_board?
     mouse_in_board_x = (mouse_x/BOARD_X_OFFSET).floor.between?(2, 9)
     mouse_in_board_y = (mouse_y/BOARD_Y_OFFSET).floor.between?(2, 9)
     mouse_in_board_x && mouse_in_board_y
  end

  def mouse_on_button?
     mouse_on_button_x = (mouse_x/BUTTON_X_OFFSET).floor.between?(1, 3)
     mouse_on_button_y = mouse_y.between? BUTTON_Y_OFFSET, BUTTON_Y_OFFSET * 2
     mouse_on_button_x && mouse_on_button_y
  end

  def coordinates_to_index(x, y)
    [LETTERS[(x/BOARD_X_OFFSET).floor - 2], (y/BOARD_Y_OFFSET - 1).floor]
  end

  def index_to_coordinates(letter, number)
    column = LETTERS.index letter
    row = number
    [BOARD_X_OFFSET * (2.25 + column), BOARD_Y_OFFSET * (1 + row)]
  end

  def draw_text(x, y, text, font_size)
    @message = Gosu::Image.from_text self, text, Gosu.default_font_name, COORDS_FONT_SIZE
    @message.draw x, y, 0
  end

  def dye_background(bg_color)
    draw_rect 0, 0, DIMENSIONS[:width], DIMENSIONS[:height], bg_color
  end
  
  def draw_rect(x, y, width, height, color)
    draw_quad x, y, color, x+width, y, color, x, y+height, color, x+width, y+height, color
  end
end
