class Game

  def main_menu
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit."
    user_input = gets.chomp
    if user_input == "p" || user_input == "P"
      setup
      game_begin
    else user_input == "q" || user_input == "Q"
      puts "Don't be a quitter, try again!"
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
    @computer_board.random_placer_helper(@computer_cruiser)
    @computer_board.random_placer_helper(@computer_submarine)
  end

  def game_begin
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships.\nThe Cruiser is #{@cruiser.length} spaces long and the Submarine is #{@submarine.length} spaces long."
    puts @board.render(true)

    loop do
      puts "Enter the coordinates for the Cruiser (e.g. A1 B1 C1):"
      user_input = gets.chomp
      formatted = user_input.upcase.delete(",").split
      if @board.valid_placement?(@cruiser, formatted) 
        @board.place(@cruiser, formatted)
        puts "You're Cruiser has successfully been placed."
        puts @board.render(true)
        break
      else
        puts "Invalid coordinates, please try again."
      end
      puts @board.render(true)
    end

    loop do
      puts "Now, enter the coordinates for the Submarine (e.g. D1 D2):"
      user_input = gets.chomp
      formatted = user_input.upcase.delete(",").split
      if @board.valid_placement?(@submarine, formatted) 
        @board.place(@submarine, formatted)
        puts "You're Submarine has successfully been placed."
        break
      else
        puts "Invalid coordinates, please try again."
      end
    end
  end

  def game_turn_start
    loop do
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @board.render(true)
      if @computer_cruiser.sunk? && @computer_submarine.sunk?
        puts "Congratulations! You've sunk both of my ships. You win!"
        break
      elsif @cruiser.sunk? && @submarine.sunk?
        puts "Well, well, well. How the turn tables, I managed to beat you this time!"
        break
      else
        player_turn
        computer_turn
      end
    end
  end
  

  def player_turn
    loop do
      puts "Enter the coordinate for your shot (e.g. A1):"
      user_input = gets.chomp
      formatted = user_input.upcase
      if @computer_board.valid_coordinate?(formatted) 
        if @computer_board.cells[formatted].fired_upon? == false
        @computer_board.cells[formatted].fire_upon
          if @computer_board.cells[formatted].render == "M"
            puts "Your shot on #{formatted} was a miss."
          elsif @computer_board.cells[formatted].render == "X"
            puts "Your shot on #{formatted} sunk my ship!"
          elsif @computer_board.cells[formatted].render == "H"
            puts "Your shot on #{formatted} was a hit!"
          end
          break
        else
          puts "You already shot that coordinate, please select a different one:"
        end
      else
        puts "Please enter a valid coordinate:" 
      end
    end
  end

  def computer_turn
    puts "It's my turn, hold onto your butts!"
    loop do 
      @computer_shot_data = @board.cells.keys.sample
      break if @board.cells[@computer_shot_data].fired_upon? == false
    end        
    @board.cells[@computer_shot_data].fire_upon
    if @board.cells[@computer_shot_data].render == "M"
      puts "My shot on #{@computer_shot_data} was a miss"
    elsif @board.cells[@computer_shot_data].render == "X"
      puts "My shot on #{@computer_shot_data} sunk your ship!"
    elsif @board.cells[@computer_shot_data].render == "H"
      puts "My shot on #{@computer_shot_data} was a hit!"
    end
  end
end

