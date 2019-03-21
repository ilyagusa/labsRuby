require_relative 'info'
class Tour
  attr_accessor :info, :dur, :price, :num_tourists, :list
  def initialize(info, dur, price, num_tourists, list)
    @info = info
    @dur = Integer(dur)
    @price = Integer(price)
    @num_tourists = Integer(num_tourists)
    @list = list
  end

  def push(elm)
    @list.push(elm)
  end

  def each
    @list.each_with_index { |value, index| print "#{index}LandMark#{value}\n" }
  end

  def to_s
    "\n#{@info}\nDuration:#{@dur}\nPrice:#{@price}\nNumTourist:#{@num_tourists}\nListLandmark:#{@list}"
  end
end
