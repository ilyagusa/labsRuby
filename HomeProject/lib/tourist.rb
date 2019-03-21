require_relative 'info'
require_relative 'person'
class Tourist
  attr_accessor :info, :fio, :land_mark, :min_price, :max_price
  def initialize(info, fio, land_mark, min_price, max_price)
    @info = info
    @fio = fio
    @land_mark = land_mark
    @min_price = Integer(min_price)
    @max_price = Integer(max_price)
  end

  def to_s
    "TOURIST:\n#{@fio}\n<Wishes:#{@info}>\nLandmark:#{@land_mark}\nRange Price(#{@min_price},#{@max_price})"
  end
end
