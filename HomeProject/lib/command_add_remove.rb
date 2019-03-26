# frozen_string_literal: true

require_relative 'input'
require_relative 'tour'
require_relative 'tourist'
require_relative 'info'
require_relative 'person'
# function
module CommandAddRemove
  include Input
  def self.add_tour(tour_db)
    puts 'selected add tour'
    landmarks = []
    info = Info.new(Input.need_string('Country or city>'), Input.need_type('Type(bus/train/plane/motorship)>'))
    duration = Input.need_num('Duration of the trip>')
    price = Input.need_num('Price of the trip>')
    num_tourists = Input.need_num('Number of tourists>')
    puts 'list landmarks(print end if you finished)>'
    loop do
      landmark = Input.need_string('Landmark>')
      next if landmark == 'end' && landmarks.empty?
      break if landmark == 'end'

      landmarks.push(landmark)
    end
    tour_db.push(Tour.new(info, duration, price, num_tourists, landmarks))
    puts tour_db
  end

  def self.remove_tour(tour_db)
    puts 'selected remove tour'
    index = Input.need_num('Index for remove t>')
    tour_db.remove(index - 1)
    puts tour_db
  end

  def self.add_tourist(tourist_db)
    puts 'selected add tourist'
    country = Input.need_string('Country or city>')
    type_tr = Input.need_type('Type transport(bus/train/plane/motorship)>')
    name = Input.need_string('Name>')
    surname = Input.need_string('Surname>')
    patr = Input.need_string('Patronymic>')
    landmark = Input.need_string('Landmark>')
    min = Input.need_num('minPrice of the trip>')
    max = Input.need_num('maxPrice of the trip>')
    min, max = max, min if min > max
    tourist_db.push(Tourist.new(Info.new(country, type_tr), Person.new(name, surname, patr), landmark, min, max))
    puts tourist_db
  end

  def self.remove_tourist(tourist_db)
    puts 'selected remove tourist'
    index = Input.need_num('Index for remove t_t>')
    tourist_db.remove(index - 1)
    puts tourist_db
  end

  def self.puts_tour(tour_db)
    puts 'selected print tour by parameter(price/country/landmark)'
    value = CommandAddRemove.tour_parameter
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
end
