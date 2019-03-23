require_relative 'tourist_data_base'
require_relative 'tour_data_base'
require_relative 'input'
require_relative 'command'
# 1
class Core
  include Input
  include Command
  def initialize
    @tour_db = TourDB.new
    @tourist_db = TouristDB.new
  end

  def run
    @tour_db = Input.read_filetours
    @tourist_db = Input.read_filetourists
    puts @tour_db
    puts @tourist_db
    menu
  end

  def menu
    tour_group = {}
    loop do
      puts 'enter command'
      a = gets.chomp
      case a
      when '1'
        Command.add_tour(@tour_db)
      when '2'
        Command.remove_tour(@tour_db)
      when '3'
        Command.add_tourist(@tourist_db)
      when '4'
        Command.remove_tourist(@tourist_db)
      when '5'
        tour_group = Command.fill_tour(@tour_db, @tourist_db)
        puts tour_group
      when '6'
        Command.tour_for_tourist(@tour_db, @tourist_db.size, tour_group)
      when 'exit'
        break
      end
    end
  end
end
