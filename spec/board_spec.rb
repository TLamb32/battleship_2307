require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

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
    end
  end

  describe "#valid_coordinate?" do
    it "checks if the coordinate is on the board" do
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe "#valid_placement?" do
    it "can check the number of coordinates in the array should be the same as the length of the ship" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)

      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to eq(true)
      expect(@board.valid_placement?(@submarine, ["A2", "A3"])).to eq(true)

      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end

  describe "#consecutive_check" do
    it "can make sure the coordinates are consecutive" do
    expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(@board.consecutive_check(@submarine, ["A1", "C1"])).to eq(false)
    expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A3"])).to eq(true)
    expect(@board.consecutive_check(@submarine, ["B1", "C1"])).to eq(true)
    end
  end

  describe "#diagonal_check" do
    it "checks if cells ar placed diagonally" do
      expect(@board.diagonal_check(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(@board.diagonal_check(@submarine, ["C2", "D3"])).to eq(false)
      expect(@board.diagonal_check(@cruiser, ["A1", "A2", "A3"])).to eq(true)

    
    end

  end

  describe "#coordinate_splitter_number" do
    it "can return an array of number coordinates" do
      expect(@board.coordinate_splitter_number(@cruiser, ["A1", "A2", "A4"])).to eq(["1", "2", "4"])
      expect(@board.coordinate_splitter_number(@submarine, ["A1", "C1"])).to eq(["1", "1"])
      expect(@board.coordinate_splitter_number(@cruiser, ["A3", "A2", "A1"])).to eq(["3", "2", "1"])
      expect(@board.coordinate_splitter_number(@submarine, ["C1", "B1"])).to eq(["1", "1"])
    end
  end

  describe "#coordinate_splitter_letter" do
    it "can return an array of letter coordinates" do
      expect(@board.coordinate_splitter_letter(@cruiser, ["A1", "A2", "A4"])).to eq(["A", "A", "A"])
      expect(@board.coordinate_splitter_letter(@submarine, ["A1", "C1"])).to eq(["A", "C"])
      expect(@board.coordinate_splitter_letter(@cruiser, ["A3", "A2", "A1"])).to eq(["A", "A", "A"])
      expect(@board.coordinate_splitter_letter(@submarine, ["C1", "B1"])).to eq(["C", "B"])
    end
  end

  describe "#consecutive_checker_numbers" do
    it "can check if the array of numbers are consecutive" do
      expect(@board.consecutive_checker_numbers(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.consecutive_checker_numbers(@submarine, ["A1", "C1"])).to eq(true)
    end
  end

  describe "#consecutive_checker_letters" do
    it "can check if the array of letters are consecutive" do
      # expect(@board.consecutive_checker_letters(@cruiser, ["A1", "A2", "A4"])).to eq(true)
      expect(@board.consecutive_checker_letters(@submarine, ["A1", "C1"])).to eq(false)
    end
  end
end
