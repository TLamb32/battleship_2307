class Cell
  attr_reader :coordinate,
              :ship
            
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_at = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon?
    @fired_at
  end

  def fire_upon
    if empty? == false
      @ship.hit
      @fired_at = true
    else
      @fired_at = true
    end
  end

  def render(option = false)
    if option == true && @ship != nil && @fired_at == false
      "S"
    elsif @ship == nil && @fired_at == true
      "M"
    elsif @ship != nil && @fired_at == true && @ship.sunk? == true
      "X"
    elsif @ship != nil && @fired_at == true
      "H"
    else @ship == nil && @fired_at == false
      "."
    end
  end

end