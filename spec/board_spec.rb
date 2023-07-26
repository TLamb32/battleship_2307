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
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.values.first).to be_a(Cell)
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

      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
      @board.place(@cruiser, ["B1", "B2", "B3"])
      expect(@board.valid_placement?(@submarine, ["B1", "B2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "C2"])).to eq(true)
    end
  end

  # Helper method tests

  describe "#consecutive_check" do
    it "can make sure the coordinates are consecutive" do
      expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.consecutive_check(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A3"])).to eq(true)
      expect(@board.consecutive_check(@submarine, ["B1", "C1"])).to eq(true)
      expect(@board.consecutive_check(@cruiser, ["C2", "A2", "B1"])).to eq(false)
    end
  end

  describe "#diagonal_check" do
    it "checks if cells are placed diagonally" do
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
      expect(@board.consecutive_checker_numbers(@cruiser, ["A1", "A2", "A4"])).to eq(false)
    end
  end

  describe "#consecutive_checker_letters" do
    it "can check if the array of letters are consecutive" do
      expect(@board.consecutive_checker_letters(@cruiser, ["A1", "A2", "A4"])).to eq(true)
      expect(@board.consecutive_checker_letters(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.consecutive_checker_letters(@cruiser, ["C2", "A2", "B1"])).to eq(false)
    end
  end

  describe "#place" do
    it "places a ship on a cell" do
      @cell_1 = @board.cells["A1"]
      @cell_2 = @board.cells["A2"]
      @cell_3 = @board.cells["A3"] 
      @cell_4 = @board.cells["A4"]
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_2.ship).to eq(@cruiser)
      expect(@cell_3.ship).to eq(@cruiser)
      expect(@cell_3.ship == @cell_2.ship).to eq(true)
      expect(@cell_3.ship == @cell_1.ship).to eq(true)
      expect(@cell_4.ship == @cell_1.ship).to eq(false)
      expect(@cell_4.ship).to eq(nil)
    end
  end

  describe "#overlapping_ships" do
    it "can check for overlapping ships" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.overlapping_ships(@submarine, ["A1", "B1"])).to eq(false)
      expect(@board.overlapping_ships(@submarine, ["B1", "B2"])).to eq(true)

      @board.place(@cruiser, ["B1", "B2", "B3"])
      expect(@board.overlapping_ships(@submarine, ["B1", "B2"])).to eq(false)
    end
  end

  describe "#render" do
    it "can render the board into a formatter grid" do
      @board.place(@cruiser, ["A1", "A2", "A3"])  

      expect(@board.render).to eq("\e[0;31;49m  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n\e[0m")

      expect(@board.render(true)).to eq("\e[0;32;49m  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n\e[0m")
    end
  end

  describe "#random_placer_helper" do
    it "can verify if random coordinates are valid" do
      expect(@board.random_placer_helper(@cruiser).length).to eq(3)
      expect(@board.random_placer_helper(@cruiser)).to be_a(Array)
      
      expect(@board.random_placer_helper(@submarine).length).to eq(2)
      expect(@board.random_placer_helper(@submarine)).to be_a(Array)
    end
  end
end
