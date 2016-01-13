require_relative 'pieces'

describe Pawn do
  context "some pawn somewhere" do
    let(:pawn) { Pawn.new([:b, 3], :black) }
    before do
      disable_errors
    end

    it "should include PluralPiece" do
      expect(Pawn).to include(PluralPiece)
    end

    it "should return correct string representation the pawn" do
      expect(pawn.to_s).to eq("♙ 2")
    end

    context "movements" do
      let(:board) { Board.new }
      it "should be able to move normally from position" do
        expect(pawn.can_move [:b, 2], board).to be true
      end

      it "should be unable to move diagonally if theres no piece there" do
        expect(pawn.can_move [:c, 2], board).to be false
      end
      
      it "should be able to take a piece that is diagonal to it" do
        pawn.move [:b, 2], board
        expect(pawn.can_move [:c, 1], board).to be true
      end
    end
  end

  context "pawn at starting position" do
    let(:board) { Board.new }
    let(:pawn) { board.get_square [:f, 6] }
    it "should be able to make first turn two squares move" do
      expect(pawn.can_move([:f, 4], board)).to be true
    end
  end
end

describe Knight do
  context "some hors... knight somewhere" do
    let(:board) { Board.new }
    let(:knight) { Knight.new([:d, 5], :white) }

    it "should be able to take the queen" do
      expect(knight.can_move([:e, 7], board)). to be true
    end

    it "should be able to take pawn 6" do
      expect(knight.can_move([:f, 6], board)). to be true
    end

    it "should be unable to go wherever he likes" do
      expect(knight.can_move([:a, 6], board)). to be false
    end
  end

  context "starting position knight" do
    let(:board) { Board.new }
    let(:knight) { board.get_square [:g, 0] }
    
    it "should be able to move in front of pawn 6 (white)" do
      expect(knight.can_move([:f, 2], board)).to be true
    end
    it "should actually move in front of pawn 6 (white)" do
      expect(knight.move([:f, 2], board)).to eq(1)
    end
  end
end

describe King do
  let(:board) { Board.new }
  context "unthreatened king" do
    let(:king) { board.get_square [:d, 7] }
    it "shouldn't be threatened there" do
      expect(king.threatened? board).to be false
    end
  end

  context "threatened king" do
    let(:king) { board.add_piece(King.new [:d, 2], :black) }
    it "should be threatened there" do
      expect(king.threatened? board).to be true
    end
  end
end
