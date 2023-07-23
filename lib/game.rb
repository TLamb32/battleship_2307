class Game

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    user_input = gets.chomp
    if user_input == "p" || user_input == "P"
      setup
      game_begin
    else user_input == "q" || user_input == "Q"
      puts "Quitter!"
      main_menu
    end
  end

  def setup
    @board = Board.new
    @computer_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  # @computer_board.place_ship.sample
  def game_begin
    puts "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long."
    puts @board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp

  end
end