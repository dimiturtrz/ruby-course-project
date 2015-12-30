describe Piece do
  describe Piece do
    let(:piece_class) { Class.new{ include Piece } }

    it "should respond to a three argument constructor" do
      expect(piece_class).to respond_to(:new).with(3).arguments
    end
  end

  describe SingularPiece do
    let(:singular_piece_class) { Class.new{ include SingularPiece } }

    it "should include Piece" do
      expect(singular_piece_class).to include(Piece)
    end

    it "should respond to a three argument constructor" do
      expect(singular_piece_class).to respond_to(:new).with(3).arguments
    end
  end

  describe PluralPiece do
    let(:plural_piece_class) { Class.new{ include PluralPiece } }

    it "should include Piece" do
      expect(plural_piece_class).to include(Piece)
    end

    it "should respond to a four argument constructor" do
      expect(plural_piece_class).to respond_to(:new).with(4).arguments
    end
  end
end

describe Pawn do
  #let(:pawn) { Pawn.new([:d, 3], :black) }

  it "should include PluralPiece" do
    expect(Pawn).to include(PluralPiece)
  end

  it "should return correct string representation the pawn" do
    expect(Pawn.new([:d, 3], :black).to_s).to eq("♟ 4")
  end
end
