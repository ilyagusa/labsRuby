require_relative 'input'
require_relative 'tour'
require_relative 'tourist'
require_relative 'info'
require_relative 'person'
# 1
module Command
  def self.add_tour(tour_db)
    landmarks = []
    country = Input.need_string('Country or city>')
    type_tr = Input.need_string('Type transport>')
    duration = Input.need_num('Duration of the trip>')
    price = Input.need_num('Price of the trip')
    num_tourists = Input.need_num('Number of tourists>')
    puts 'list landmarks(use enter twice to end)>'
    loop do
      landmark = Input.need_string('Landmark>')
      break if landmark == 'q'

      landmarks.push(landmark)
    end
    tour_db.push(Tour.new(Info.new(country, type_tr), duration, price, num_tourists, landmarks))
    puts tour_db
  end

  def self.remove_tour(tour_db)
    index = Input.need_num('Index for remove tour>')
    tour_db.remove(index - 1)
    puts tour_db
  end

  def self.add_tourist(tourist_db)
    country = Input.need_string('Country or city>')
    type_tr = Input.need_string('Type transport>')
    name = Input.need_string('Name>')
    surname = Input.need_string('Surname>')
    patr = Input.need_string('Patronymic>')
    landmark = Input.need_string('Landmark>')
    min = Input.need_num('minPrice of the trip')
    max = Input.need_num('maxPrice of the trip')
    if min > max
      tmp = min
      min = max
      max = tmp
    end
    tourist_db.push(Tourist.new(Info.new(country, type_tr), Person.new(name, surname, patr), landmark, min, max))
    puts tourist_db
  end

  def self.remove_tourist(tourist_db)
    index = Input.need_num('Index for remove tourist>')
    tourist_db.remove(index - 1)
    puts tourist_db
  end



  def fill_tour_group(tour_db,tourist_db)
    tour_group=Hash.new
          
  end



end
