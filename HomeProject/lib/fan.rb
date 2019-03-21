require_relative 'tour'
require_relative 'tour_data_base'
require_relative 'tourist_data_base'
tdb = TourDB.new
tdb.push(Tour.new(Info.new('shopsha', 'bus'), 5, 3500, 10, ['kreml', 'red square']))
tdb.push(Tour.new(Info.new('amereka', 'tank'), 5, 3500, 10, ['park', 'red square']))
tdb.push(Tour.new(Info.new('germania', 'btr'), 5, 5000, 10, ['reixstag', 'red square']))
puts tdb
ttdb = TouristDB.new
ttdb.push(Tourist.new(Info.new('antarktida', 'ledokol'), Person.new('ilya', 'gusev', 'sergeevich'), 'lednik', 300, 1000))
puts ttdb
