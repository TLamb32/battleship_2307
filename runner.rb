require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game.rb'
require 'colorize'

@game = Game.new

loop do
  @game.main_menu
  @game.game_turn_start
end
