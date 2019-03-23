require_relative 'input'
require_relative 'tour'
require_relative 'tourist'
require_relative 'info'
require_relative 'person'
# 1
module Command
  def self.whyprice(price, min_p, max_p)
    true if price <= max_p && price >= min_p
  end

  # check on the coincidence of all the parameters to choose a tour for the tourist
  def self.fill_tour(tour_db, tourists_db)
    tour_group = {}
    tour_db.each_with_index do |t, i|
      mass = []
      tmp = t.num_tourists
      tourists_db.each_with_index do |t_t, i1|
        next unless t_t.occupancy == true && t.num_tourists >= 1 && (t.landmarks.include? t_t.land_mark) &&
                    t.info.gen == t_t.info.gen && Command.whyprice(t.price, t_t.min_p, t_t.max_p)

        t_t.occupancy = false
        mass << "#{i1 + 1} tourist"
        t.num_tourists -= 1
      end
      tour_group["#{i + 1} TOUR"] = mass
      t.num_tourists = tmp
    end
    tour_group
  end

  def self.tour_for_tourist(tour_db, size, tour_group)
    return puts 'First you need to distribute the tourists into groups' if tour_group.empty?

    touristindex = nil
    loop do
      touristindex = Input.need_num('input true index>')
      break if touristindex <= size
    end
    puts touristindex
    tour_group.each do |key, value|
      if value.include? "#{touristindex} tourist"
        puts "for this <<#{touristindex} tourist>> picked up this tour>"
        puts tour_db.tour(key.to_i - 1)
      end
    end
  end

  def self.puts_tour(tour_db)
    value = Command.tour_parameter
    case value[0]
    when 'price'
      tour_db.puts_by_price(value[1])
    when 'country'
      tour_db.puts_by_country(value[1])
    when 'landmark'
      tour_db.puts_by_landmark(value[1])
    end
  end

  def self.tour_parameter
    result = []
    parameter = Input.need_parameter
    result << parameter
    case parameter
    when 'price'
      result << Input.need_num("#{parameter}>")
    when 'country'
      result << Input.need_string("#{parameter}>")
    when 'landmark'
      result << Input.need_string("#{parameter}>")
    end
    result
  end

  def self.puts_list_tourist(size, tourist_db, tour_group)
    tour_index = nil
    loop do
      tour_index = Input.need_num('input true index>')
      break if tour_index <= size
    end
    tour_group.each do |key, value|
      if key.to_i == tour_index
        puts "IN <<#{tour_index} TOUR>> these tourists>"
        value.each { |x| puts tourist_db.tourist(x.to_i - 1) }
      end
    end
  end
end