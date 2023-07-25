require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game_new.rb'

@game = Game.new

@game.main_menu
@game.game_turn_start
# @game.player_turn