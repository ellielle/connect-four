require "./lib/connect_four"

describe ConnectFour do
  subject(:connectfour){ ConnectFour.new }
  let(:turn){ subject.instance_variable_get(:@turn) }
  before(:all) { system("cls") }
  describe "initialization" do
    context "when a new game is started" do
      it "initializes players properly" do
        expect(subject.players).to have_value("\u2620").and have_value("\u2622")
      end
      it "creates the game board" do
        board = subject.instance_variable_get(:@gameboard)
        expect(board).not_to be_nil
      end
      it "sets up turns correctly" do
        expect(turn).to match(["player1", "player2"])
      end
    end
  end
  describe "#change_turn" do
    context "when called" do
      it "changes to the next player's turn" do
        subject.send(:change_turn)
        expect(turn[0]).to eql("player2")
      end
    end
  end
  describe "#valid_move?" do
    context "when user in puts a move" do
      it "allows values between 1 and 7" do
        valid = subject.send(:valid_move?, "1")
        expect(valid).to be true
      end
      it "doesn't allow values not between 1 and 7" do
        valid = subject.send(:valid_move?, "a")
        expect(valid).to be false
      end
      it "doesn't allow empty values" do
        valid = subject.send(:valid_move?, "")
        expect(valid).to be false
      end
    end
  end
  describe "#add_to_board" do
    context "when passed player1's move" do
      it "adds player1's piece to the correct slot" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][3] = "\u2620"
        subject.send(:add_to_board, 3)
        test_board = subject.instance_variable_get(:@gameboard)
        expect(board).to eql(test_board)
      end
    end
    context "when passed player2's move" do
      it "adds player2's piece to the correct slot" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][3] = "\u2622"
        subject.instance_variable_set(:@turn, "player2")
        subject.send(:add_to_board, 3)
        test_board = subject.instance_variable_get(:@gameboard)
        expect(board).to eql(test_board)
      end
    end
    context "when board already has pieces" do
      it "adds piece to correct slot" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][3] = "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        board[1][3] = "\u2620"
        subject.send(:add_to_board, 3)
        test_board = subject.instance_variable_get(:@gameboard)
        expect(board).to eql(test_board)
      end
    end
  end
  describe "#check_horizontal" do
    context "when 4 matching pieces are connected horizontally" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][1], board[0][2], board[0][3], board[0][4] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_horizontal, 0, 4)
        expect(result).to be true
      end
    end
    context "when 4 matching pieces are connected horizontally" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][3], board[0][4], board[0][5], board[0][6] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_horizontal, 0, 3)
        expect(result).to be true
      end
    end
    context "when there are not 4 matching pieces horizontally" do
      it "returns false" do
        result = subject.send(:check_horizontal, 0, 4)
        expect(result).to be false
      end
    end
  end
  describe "#check_vertical" do
    context "when 4 matching pieces are connected vertically" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][1], board[1][1], board[2][1], board[3][1] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_vertical, 0, 1)
        expect(result).to be true
      end
    end
    context "when 4 matching pieces are connected vertically" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[2][1], board[3][1], board[4][1], board[5][1] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_vertical, 2, 1)
        expect(result).to be true
      end
    end
    context "when there are not 4 matching pieces vertically" do
      it "returns false" do
        result = subject.send(:check_vertical, 2, 1)
        expect(result).to be false
      end
    end
  end
  describe "#check_diagonal" do
    context "when 4 matching pieces are connected diagonally" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[0][0], board[1][1], board[2][2], board[3][3] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_diagonal, 0, 0)
        expect(result).to be true
      end
    end
    context "when 4 matching pieces are connected diagonally" do
      it "returns true" do
        board = subject.instance_variable_get(:@gameboard)
        board[2][2], board[3][3], board[4][4], board[5][5] = "\u2620", "\u2620", "\u2620", "\u2620"
        subject.instance_variable_set(:@gameboard, board)
        result = subject.send(:check_diagonal, 2, 2)
        expect(result).to be true
      end
    end
    context "when there are not 4 matching pieces diagonally" do
      it "returns false" do
        result = subject.send(:check_diagonal, 3, 3)
        expect(result).to be false
      end
    end
  end
end