require_relative 'tour_data_base'
require_relative 'tourist_data_base'
require_relative 'input'
require_relative 'command'
# 1
class Core
  include Input
  include Command
  def initialize
    @tour_db = TourDB.new
    @tourist = TouristDB.new
  end

  def run
    @tour_db = Input.read_filetours
    @tourist = Input.read_filetourists
    puts @tour_db
    puts @tourist
    menu
  end

  def menu
    puts 'enter command'
    a = gets.chomp
    case a
    when '1'
      Command.add_tour(@tour_db)
    when '2'
      Command.remove_tour(@tour_db)
    when '3'
      Command.add_tourist(@tourist)
    when '4'
      Command.remove_tourist(@tourist)
    end
  end
end
