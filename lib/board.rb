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

  # def valid_placement?(ship, coordinates)
  #   ship.length == coordinates.count && consecutive_check(ship, coordinates) == true
    # require 'pry'; binding.pry
  # end

  def consecutive_check(ship, coordinates)
    if (consecutive_checker_letters(ship, coordinates) == true && consecutive_checker_numbers(ship, coordinates) == false)
      false
    elsif (consecutive_checker_letters(ship, coordinates) == false && consecutive_checker_numbers(ship, coordinates) == true)
      false
    else 
      true
    end
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
end