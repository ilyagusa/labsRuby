class Fleet

  def initialize
    @cars=Array.new
  end

  def add(car)
    @cars.push(car)
  end

  def car(index)
    @cars[index]
  end

  def avgexpense
    sum=0
    @cars.each do |car| 
    sum+=car.expense
    end
    sum/@cars.size
  end


  def count_brand(brand)
    count=0
    @cars.count{|car| car.brand==brand}
  end

  def count_model(model)
    count=0
    @cars.count{|car| car.model==model}
  end

  def avgexpense_for_brand(brand)
    avg=0
    a=@cars.select{|car|  car.brand==brand }
    a.each{|car| avg+=car.expense}
    return avg/a.size
  end

end