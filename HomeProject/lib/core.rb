# frozen_string_literal: true

require_relative 'tourist_data_base'
require_relative 'tour_data_base'
require_relative 'input'
require_relative 'command_add_remove'
require_relative 'person'
require_relative 'info'
# menu
class Core
  include Input
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
    loop do
      help
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
        fill_tour
        puts @tour_group
      when '6'
        tour_for_tourist
      when '7'
        CommandAddRemove.puts_tour(@tour_db)
      when '8'
        puts_list_tourist
      when 'exit'
        break
      else puts 'Uncorrect command'
      end
    end
  end

  def whyprice(price, min_p, max_p)
    true if price <= max_p && price >= min_p
  end

  def fill_tour
    @tour_group = {}
    @tourist_db.swapocc
    @tour_db.each_with_index do |t, i|
      mass = []
      tmp = t.num_tourists
      @tourist_db.each_with_index do |t_t, i1|
        next unless t_t.occupancy == true && tmp >= 1 && (t.landmarks.include? t_t.land_mark) &&
                    t.info.gen == t_t.info.gen && whyprice(t.price, t_t.min_p, t_t.max_p)

        t_t.occupancy = false
        mass << "#{i1 + 1} tourist"
        tmp -= 1
      end
      @tour_group["#{i + 1} TOUR"] = mass
    end
  end

  def tour_for_tourist
    puts 'selected print tour for tourist'
    return puts 'First you need to distribute the tourists into groups' if @tour_group.empty?

    touristindex = nil
    loop do
      touristindex = Input.need_num('input true index tourist>')
      break if touristindex <= @tourist_db.size
    end
    puts "for <<#{touristindex} tourist>> picked up this tour>"
    @tour_group.each do |key, value|
      puts @tour_db.tour(key.to_i - 1) if value.include? "#{touristindex} tourist"
    end
  end

  def puts_list_tourist
    puts 'selected print all tourist in tour'
    return puts 'First you need to distribute the tourists into groups' if @tour_group.empty?

    a = TouristDB.new
    tour_index = nil
    loop do
      tour_index = Input.need_num('input true index tour>')
      break if tour_index <= @tour_db.size
    end
    @tour_group.each do |key, value|
      if key.to_i == tour_index
        puts "IN <<#{tour_index} TOUR>> these tourists>"
        value.each { |x| a.push(@tourist_db.tourist(x.to_i - 1)) }
      end
    end
    puts a.sort
  end

  def help
    puts "\nMENU:::\n1/3-add(Tour/Tourist)\n2/4-remove(Tour/Tourist)"
    puts "5-select tour\n6-print tour for tourist\n7-print tour by param\n8-print tourists by tour\n"
    print "exit-end programm\n\n"
    print 'Select command>>>'
  end
end
