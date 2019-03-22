require_relative 'tourist'
# 1
class TouristDB
  def initialize
    @tourist_db = []
  end

  def push(tourist)
    @tourist_db.push(tourist)
  end

  def tour(index)
    @tourist_db[index]
  end

  def remove(index)
    @tourist_db.delete_at(index)
  end

  def to_s
    str = ''
    @tourist_db.each_with_index { |value, index| str += "#{index + 1} TOURIST:#{value}\n\n" }
    str
  end
end
