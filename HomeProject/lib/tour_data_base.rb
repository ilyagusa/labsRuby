require_relative 'tour'
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

  def to_s
    str=""
    @tour_db.each_with_index { |value, index| str+="#{index + 1} TOUR:#{value}\n\n" }
    return str
  end
end

