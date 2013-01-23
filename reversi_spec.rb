require 'rspec'
require_relative 'reversi'
include Reversi

describe Board do
  subject(:game) {Board.new}
  let (:player) {double("player", :color => :white)}
  it "starts a new board with correct dimensions" do
    game.board.length.should == 8
    game.board[0].length.should == 8
  end

  it "should have pieces in correct positions" do
    game.board[3][3].should == :white
    game.board[4][4].should == :white
    game.board[3][4].should == :black
    game.board[4][3].should == :black
  end

  # describe "#play" do

  # end

  describe "#make_move" do
    it "should change tile" do
      game.make_move([6,"D"], player.color)
      game.board[5][3].should == :white
    end

    it "changes the tiles in the path" do
      game.make_move([4, "F"], player.color)
      game.board[3][4].should == :white
      game.board[3][5].should == :white
    end

    it "raises an error if the path does not end with my tile" do
      expect do
        game.make_move([3,"F"], player.color)
      end.to raise_error("illegal move")
    end

    it "raises an error if the tile is not adjacent to any tiles" do
      expect do
        game.make_move([1,"H"], player.color)
      end.to raise_error("illegal move")
    end
  end

  describe "#valid_move?" do
    xit "should raise an error on an illegal move" do
      expect do
        game.make_move()
      end
    end
  end
end

# describe Player do
#   subject(:player) {Player.new("p")}

  
# end