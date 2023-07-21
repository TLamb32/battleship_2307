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
    @ship.hit 
    @fired_at = true
  end
end