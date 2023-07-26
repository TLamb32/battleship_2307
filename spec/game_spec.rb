require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  describe "game" do
    it "can instantiate a game" do
      game_1 = Game.new

      expect(game_1).to be_a Game
    end
  end
end