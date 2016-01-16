class ChessError < StandardError
end

module Error
  @@errors_enabled = true

  def self.enable_errors
    @@errors_enabled = true
  end

  def self.disable_errors
    @@errors_enabled = false
  end

  def self.raise_chess_error(message)
    raise ChessError.new message if @@errors_enabled
    false
  end
end
