require_relative 'constants'
require 'gosu'
include Gosu

class GameWindow < Window
  def initialize
    super DIMENSIONS[:width], DIMENSIONS[:height]
    self.caption = "Gosu Tutorial Game"
  end

  def draw
    dye_background Color::BLUE
    draw_board
  end

  def draw_board
    start_x, start_y = DIMENSIONS[:width]/12, DIMENSIONS[:height]/10
    end_y = nil
    (1..8).each do |row|
      y = start_y+(row*DIMENSIONS[:height]/12)
      draw_text start_x, y, row
      (1..8).each do |cell|
        x = start_x+(cell*DIMENSIONS[:width]/12)
        col = (row+cell).even? ? Color::BLACK : Color::WHITE
        draw_rect x, y, DIMENSIONS[:width]/12, DIMENSIONS[:height]/12, col
      end
    end_y = y + DIMENSIONS[:width]/12
    end
    8.times{|number| draw_text start_x+((1+number)*DIMENSIONS[:width]/12), end_y,LETTERS[number]}
  end

  def draw_text x, y, text
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
