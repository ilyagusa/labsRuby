class Fleet
  def initialize
    @cars=Array.new
  end
  def add(car)
    @cars.push(car)
  end
end