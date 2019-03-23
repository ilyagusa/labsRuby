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

  def size
    @tour_db.size
  end

  def each_with_index
    @tour_db.each_with_index { |tour, index| yield(tour, index) }
  end

  def each
    @tour_db.each { |tour| yield(tour) }
  end

  def puts_by_price(price)
    @tour_db.each do |tour|
      puts tour if tour.price == price
    end
  end

  def puts_by_country(country)
    @tour_db.each do |tour|
      puts tour if tour.country == country
    end
  end

  def puts_by_landmark(landmark)
    @tour_db.each do |tour|
      puts tour if tour.landmarksarray.include? landmark.to_s
    end
  end

  def to_s
    str = ''
    @tour_db.each_with_index { |value, index| str += "#{index + 1} TOUR:#{value}\n\n" }
    str
  end
end
