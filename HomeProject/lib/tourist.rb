require_relative 'info'
require_relative 'person'
# 1
class Tourist
  attr_accessor :info, :fio, :land_mark, :min_p, :max_p, :occupancy
  def initialize(info, fio, land_mark, min_p, max_p)
    @info = info
    @fio = fio
    @land_mark = land_mark
    @min_p = Integer(min_p)
    @max_p = Integer(max_p)
    @occupancy = true
  end

  def to_s
    "\n#{@fio}\nWishes:\n<<\n#{@info}Landmark:#{@land_mark}\nRange Price(#{@min_p},#{@max_p})\n>>"
  end
end
