class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if (ship.length == coordinates.count) &&
    consecutive_check(ship, coordinates) &&
    diagonal_check(ship, coordinates) && 
    overlapping_ships(ship, coordinates)
      true
    else
      false
    end
  end

  def consecutive_check(ship, coordinates)
   consecutive_checker_letters(ship, coordinates) && coordinate_splitter_number(ship, coordinates).uniq.length == 1 || consecutive_checker_numbers(ship, coordinates) && coordinate_splitter_letter(ship, coordinates).uniq.length == 1
  end

  def diagonal_check(ship, coordinates)
    number_d = nil
    letter_d = nil
    coordinate_splitter_number(ship, coordinates).each_cons(2).all? do |number_1, number_2|
      number_d = number_2.to_i - number_1.to_i == 1 
    end
    coordinate_splitter_letter(ship, coordinates).each_cons(2).all? do |letter_1, letter_2|
      letter_d = letter_2.ord - letter_1.ord == 1 
    end
    if number_d && letter_d == true
      false
    else
      true
    end
  end

  def coordinate_splitter_number(ship, coordinates) #helper method
    number_collector = []
    coordinates.each do |coordinate|
      number_collector << coordinate.delete("^0-9")
    end
      number_collector
  end

  def coordinate_splitter_letter(ship, coordinates) #helper method
    letter_collector = []
    coordinates.each do |coordinate|
      letter_collector << coordinate.delete("^A-Z")
    end 
    letter_collector
  end

  def consecutive_checker_numbers(ship, coordinates) #helper method
    coordinate_splitter_number(ship, coordinates).each_cons(2).all? do |number_1, number_2|
      number_2.to_i - number_1.to_i == 1 || number_2.to_i - number_1.to_i == 0
    end
  end

  def consecutive_checker_letters(ship, coordinates) #helper method
    coordinate_splitter_letter(ship, coordinates).each_cons(2).all? do |letter_1, letter_2|
      letter_2.ord - letter_1.ord == 1 || letter_2.ord - letter_1.ord == 0
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      if @cells.key?(coordinate)
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def overlapping_ships(ship, coordinates)
    coordinates.all? do |coordinate|
      @cells.key?(coordinate) && @cells[coordinate].empty?  
    end
  end
  
  def render(option = false)
    if option == false  
      ("  1 2 3 4 \n" + "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" + "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" + "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" + "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n").colorize(:red)
    else option == true
      ("  1 2 3 4 \n" + "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" + "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" + "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" + "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n").colorize(:green)
    end
  end

  def random_placer_helper(ship)
    coordinates_needed = @cells.keys
    random_coordinates = coordinates_needed.sample(ship.length)
    until valid_placement?(ship, random_coordinates)
      random_coordinates = coordinates_needed.sample(ship.length)
    end
    random_coordinates
    place(ship, random_coordinates)
  end
end