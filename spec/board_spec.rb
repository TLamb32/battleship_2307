require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)

    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")

    @board = Board.new
  end

  describe "#initialize" do
    it "can instantiate a board" do
      expect(@board).to be_an_instance_of(Board)
    end
  
    it "has readable attributes" do
      expect(@board.cells).to be_a Hash
      expect(@board.cells.values.first).to be_a Cell
      expect(@board.cells.length).to eq(16)
      require 'pry';binding.pry

    end
  end
end
