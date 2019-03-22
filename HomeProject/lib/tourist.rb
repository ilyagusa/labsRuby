require_relative 'info'
require_relative 'person'
# 1
class Tourist
  attr_accessor :info, :fio, :land_mark, :min_price, :max_price, :occupancy
  def initialize(info, fio, land_mark, min_price, max_price)
    @info = info
    @fio = fio
    @land_mark = land_mark
    @min_price = Integer(min_price)
    @max_price = Integer(max_price)
    @occupancy = true
  end

  def to_s
    "\n#{@fio}\nWishes:\n<<\n#{@info}Landmark:#{@land_mark}\nRange Price(#{@min_price},#{@max_price})\n>>"
  end
end
