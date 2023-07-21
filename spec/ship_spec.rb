require './lib/ship'

RSpec.describe Ship do
  before do 
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "can instantiate a ship" do
      expect(@cruiser).to be_an_instance_of(Ship)
    end

    it "has readable attributes" do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
    end
  end

  describe "#sunk?" do
    it "can be sunk" do
      expect(@cruiser.sunk?).to eq(false)
    end

    it "can be sunk after it's hit 3 times" do
      expect(@cruiser.health).to eq(3)
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
      @cruiser.hit
      expect(@cruiser.health).to eq(1)
      expect(@cruiser.sunk?).to eq(false)
      @cruiser.hit
      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to eq(true)
    end
  end



end