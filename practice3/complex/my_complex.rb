class MyComplex
  def initialize(real,imagine)
    @real=Float(real)
    @imagine=Float(imagine)
  end

  def to_s
    "#{@real}+i*#{@imagine}"
  end

  def real=(new_real)
    @real=Float(new_real)
  end

  def imagine=(new_imagine)
    @imagine=new_imagine
  end

  def imagine
  @imagine
  end

  def real
    @real
  end

  def add(other)
    MyComplex.new(other.real+@real,other.imagine+@imagine)
  end

  def sub(other)
   MyComplex.new(other.real-@real,other.imagine-@imagine)  
  end

  def mult(other)
    
  end
  
end

