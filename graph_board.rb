require_relative 'constants'
require 'gosu'
include Gosu

class GameWindow < Window
  def initialize board
    super DIMENSIONS[:width], DIMENSIONS[:height]
    self.caption = "Gosu Tutorial Game"

    @board = board
    get_piece_icons

    @pointer = Gosu::Image.new self, "icons/pointer.png", true
    @px = @py = 0
  end

  def draw
    dye_background Color::BLUE
    draw_board
    draw_pieces
    @pointer.draw @px, @py, 0
  end
	
  def update
    place_mouse
  end

  def place_mouse
    @px = mouse_x
    @py = mouse_y
  end

  def draw_pieces
    @board.get_pieces.each do |piece|
      piece_icon = @piece_icons[get_piece_sym(piece)]
      x, y = get_piece_coordinates piece
      puts "x: #{x}, y: #{y}\n"
      piece_icon.draw x, y ,0
    end
  end

  def draw_board
    start_x, start_y = BOARD_X_OFFSET, BOARD_Y_OFFSET
    end_y = nil
    (1..8).each do |row|
      y = start_y + (row * BOARD_Y_OFFSET)
      draw_text start_x, y, row
      (1..8).each do |cell|
        x = start_x + (cell * BOARD_X_OFFSET)
        col = (row + cell).even? ? Color::BLACK : Color::WHITE
        draw_rect x, y, BOARD_X_OFFSET, BOARD_Y_OFFSET, col
      end
    end_y = y + BOARD_X_OFFSET
    end
    8.times do |number|
      draw_text start_x + ((1+number) * BOARD_X_OFFSET), end_y, LETTERS[number]
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

  def get_piece_coordinates(piece)
    column = LETTERS.index piece.letter
    row = piece.number
    [BOARD_X_OFFSET * (2.25 + column), BOARD_Y_OFFSET * (1 + row)]
  end

  def draw_text(x, y, text)
    @message = Gosu::Image.from_text self, text, Gosu.default_font_name, FONT_SIZE
    @message.draw x, y, 0
  end

  def dye_background(bg_color)
    draw_rect 0, 0, DIMENSIONS[:width], DIMENSIONS[:height], bg_color
  end
  
  def draw_rect(x, y, width, height, color)
    draw_quad x, y, color, x+width, y, color, x, y+height, color, x+width, y+height, color
  end
end
