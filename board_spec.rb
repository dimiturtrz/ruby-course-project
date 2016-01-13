require_relative 'board'

describe Board do
  let(:board) { Board.new }
  
  it "should have the intended string representation" do
    expect(board.to_s).to eq <<-EOS
1  ♜ 1│♞ 1│♝ 1│ ♛ │ ♚ │♝ 2│♞ 2│♜ 2
2  ♟ 1│♟ 2│♟ 3│♟ 4│♟ 5│♟ 6│♟ 7│♟ 8
3     │   │   │   │   │   │   │   
4     │   │   │   │   │   │   │   
5     │   │   │   │   │   │   │   
6     │   │   │   │   │   │   │   
7  ♙ 1│♙ 2│♙ 3│♙ 4│♙ 5│♙ 6│♙ 7│♙ 8
8  ♖ 1│♘ 1│♗ 1│ ♔ │ ♕ │♗ 2│♘ 2│♖ 2
    A   B   C   D   E   F   G   H
EOS
  end

  it "should find king by color" do
    expect(board.get_king :black).to eq(board.get_square([:d, 7]))
  end
end
