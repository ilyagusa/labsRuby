require_relative 'tourist'
require_relative 'tour_data_base'
require_relative 'tourist_data_base'
require_relative 'input'

class Fan
  attr_accessor :f,:d
  def initialize
    @f = Input.read_filetours
    @d = Input.read_filetourists
  end
end

a=Fan.new
puts a.f

puts a.d
