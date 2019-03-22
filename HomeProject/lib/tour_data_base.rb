require_relative 'tour'
# 1
class TourDB
  def initialize
    @tour_db = []
  end

  def push(tour)
    @tour_db.push(tour)
  end

  def tour(index)
    @tour_db[index]
  end

  def remove(index)
    @tour_db.delete_at(index)
  end

  def each_with_index
    @tour_db.each_with_index { |tour, index| yield(tour, index) }
  end

  def to_s
    str = ''
    @tour_db.each_with_index { |value, index| str += "#{index + 1} TOUR:#{value}\n\n" }
    str
  end
end
