class Auto
  def initialize(brand,model,old,expense)
    @brand=brand
    @model=model
    @old=Integer(old)
    @expense=Float(expense)
  end

  def brand
    @brand
  end

  def model
    @model
  end

  def old
    @old
  end

  def expense
    @expense
  end

  def to_s
    "Brand:#{@brand}\nModel:#{@model}\nOld:#{@old}\nExpense:#{expense} at 100 km\n----------\n"
  end

end