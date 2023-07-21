require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "can instantiate a cell" do
      expect(@cell).to be_an_instance_of(Cell)
    end
  
    it "has readable attributes" do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
    end
  end

  describe "#empty?" do
    it "shows if the cell is empty" do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe "#place_ship" do
    it "can place a ship" do
      expect(@cell.empty?).to eq(true)

      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end
end