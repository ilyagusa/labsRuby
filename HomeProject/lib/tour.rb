# frozen_string_literal: true

require_relative 'info'
# 1
class Tour
  attr_accessor :info, :dur, :price, :num_tourists, :list
  def initialize(info, dur, price, num_tourists, list)
    @info = info
    @dur = dur
    @price = price
    @num_tourists = num_tourists
    @list = list
  end

  def country
    @info.country
  end

  def push(elm)
    @list.push(elm)
  end

  def landmarks
    str = ''
    @list.each { |value| str += "#{value} " }
  end

  def landmarksarray
    str = []
    @list.each { |value| str << value.to_s }
  end

  def to_s
    "\n#{@info}Duration:#{@dur}\nPrice:#{@price}\nNumTourist:#{@num_tourists}\nListLandmark: #{@list}"
  end
end
