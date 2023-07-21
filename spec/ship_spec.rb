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
end