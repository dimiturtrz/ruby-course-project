require_relative 'piece_base'

describe Piece do
  describe Piece do
    let(:piece_class) { Class.new{ include Piece } }

    it "should respond to a three argument constructor" do
      expect(piece_class).to respond_to(:new).with(3).arguments
    end
  end

  describe "Piece moevment checks" do
    let(:board) { Board.new }
    let(:piece) { Queen.new [:e, 4], :white }
    
    describe "#direction_check" do
      it "should check for diagonal direction movement correctly" do
        expect(piece.direction_check 4, 2, 2, :diagonal).to be true
      end

      it "should fail to go straight with diagonal direction" do
        expect(piece.direction_check 4, 2, 2, :straight).to be false
      end
    end

    describe "#limits_check" do
      it "should be able to go further than one square with the limit off" do
        expect(piece.limits_check 4, 2, 2, false).to be true
      end

      it "shouldn't be able to go beyond the one square limit" do
        expect(piece.limits_check 4, 2, 2, true).to be false
      end

      it "should be able to go to adjacent square with the limit on" do
        expect(piece.limits_check 4, 3, 3, true).to be true
      end
    end
    
    describe "#get_squares_to_pass" do
      it "should get the right squares" do
        expect(piece.get_squares_to_pass(4, 2, 2)).to eq([[:d, 3], [:c, 2]])
      end
    end

    describe "#obstructions_check" do
      it "should return the last square" do
        expect(piece.obstructions_check(4, 1, 1, board).to_s).to eq("♟ 2")
      end
      it "should return false if there's a piece in the way" do
        expect(piece.obstructions_check(4, 0, 0, board)).to be false
      end
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
