require_relative 'tourist_data_base'
require_relative 'tour_data_base'
require_relative 'input'
require_relative 'command'
require_relative 'command_add_remove'
# menu
class Core
  include Input
  include Command
  include CommandAddRemove
  def initialize
    @tour_db = TourDB.new
    @tourist_db = TouristDB.new
    @tour_group = {}
  end

  def run
    @tour_db = Input.read_filetours
    @tourist_db = Input.read_filetourists
    puts @tour_db
    puts @tourist_db
    menu
  end

  def menu
    puts "\nMENU:::\n1/3-add(Tour/Tourist)\n2/4-remove(Tour/Tourist)"
    puts "5-select tour\n6-print tour for tourist\n7-print tour by param\n8-print tourists by tour\n"
    print "exit-end programm\n"
    loop do
      print 'Select command>>>'
      a = gets.chomp
      case a
      when '1'
        CommandAddRemove.add_tour(@tour_db)
      when '2'
        CommandAddRemove.remove_tour(@tour_db)
      when '3'
        CommandAddRemove.add_tourist(@tourist_db)
      when '4'
        CommandAddRemove.remove_tourist(@tourist_db)
      when '5'
        @tour_group = Command.fill_tour(@tour_db, @tourist_db)
        puts @tour_group
      when '6'
        Command.tour_for_tourist(@tour_db, @tourist_db.size, @tour_group)
      when '7'
        Command.puts_tour(@tour_db)
      when '8'
        Command.puts_list_tourist(@tour_db.size, @tourist_db, @tour_group)
      when 'exit'
        break
      else puts 'Uncorrect command'
      end
    end
  end
end
