require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)

    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
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

  describe "#fired_upon? and action #fire_upon" do
    it "can determine if its been fired upon" do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end

    it "can fire upon a ship" do
      @cell.place_ship(@cruiser)

      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)

      @cell.fire_upon

      expect(@cell.ship.health).to eq(1)
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe "#render" do
    it "”.” if the cell has not been fired upon" do
      expect(@cell_1.render).to eq(".")
      expect(@cell_2.render).to eq(".")
    end

    it "“M” if the cell has been fired upon and it does not contain a ship" do
      expect(@cell_1.render).to eq(".")
      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")
    end

    it "renders ""S"" if the cell is a ship but has not been fired upon" do
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq(".")
      expect(@cell_2.render(true)).to eq("S")
    end

    it "“H” if the cell has been fired upon and it contains a ship (the shot was a hit)" do
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq(".")
      @cell_2.fire_upon
      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to eq(false)
    end

    it "“X” if the cell has been fired upon and its ship has been sunk" do
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      expect(@cruiser.sunk?).to eq(false)
      @cruiser.hit
      @cruiser.hit
      # @cruiser.hit

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end

end