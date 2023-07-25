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
    @computer_board.random_placer_helper(@computer_cruiser)
    @computer_board.random_placer_helper(@computer_submarine)
    # @computer_shot = @board.cells.keys.sample
  end

  # @computer_board.place_ship.sample
  def game_begin 
    puts "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is #{@cruiser.length} spaces long and the Submarine is #{@submarine.length} spaces long."
    puts @board.render(true)

    loop do
      puts "Enter the squares for the Cruiser (3 spaces):"
      user_input = gets.chomp
      formatted = user_input.upcase.delete(",").split
      if @board.valid_placement?(@cruiser, formatted) 
        @board.place(@cruiser, formatted)
        puts "Great placement!"
        puts @board.render(true)
        break
      else
        puts "Invalid coordinates, please try again."
      end
      puts @board.render(true)
    end

    loop do
      puts "Now, place your submarine!"
      # puts @board.render(true)
      user_input = gets.chomp
      formatted = user_input.upcase.delete(",").split
        if @board.valid_placement?(@submarine, formatted) 
          @board.place(@submarine, formatted)
          puts "Great placement!"
          puts @board.render(true)
          break
        else
          puts "Invalid coordinates, please try again."
          end
          puts @board.render(true)
    end

    loop do
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @board.render(true)
      puts "Enter the coordinate for your shot:"
      user_input = gets.chomp
      formatted = user_input.upcase
        if @computer_board.valid_coordinate?(formatted) && @computer_board.cells[formatted].fire_upon == true
          if @computer_board.cells[formatted].empty? == false
            puts "You hit my ship!"
            puts @computer_board.render(true)
          else
            puts "You missed"
            puts @computer_board.render(true)
          end
          # puts @computer_board.render(true)
          
        else
          puts "Please enter a valid coordinate:" 
          break
        end
      puts "I will now take my turn!"
      @computer_shot_data = @board.cells.keys.sample
      if @board.cells[@computer_shot_data].fired_upon? == true #loop until not fired upon
        @computer_shot_data = @board.cells.keys.sample
          if @board.cells[@computer_shot_data].fire_upon == true
            @computer_shot_data = @board.cells.keys.sample
          elsif @board.valid_coordinate(@computer_shot_data)
            @computer_shot_data
            puts @board.render(true)
            computer_shot_data
          end
          break
        #   @computer_shot_data = @board.cells.keys.sample
        # if @board.valid_coordinate?(@computer_shot_data)
        #   @computer_shot_data
        
      end
      
      @computer_shot_data
      
      
      if @board.cells[@computer_shot_data].render == "M"
        puts "My shot on #{@computer_shot_data} was a miss"
      elsif @board.cells[@computer_shot_data].render == "X"
        puts "My shot on #{@computer_shot_data} sunk your ship!"
      elsif @board.cells[@computer_shot_data].render == "H"
        puts "My shot on #{@computer_shot_data} was a hit!"
      end
      
      # loop do
      # end
    end



  end
end
