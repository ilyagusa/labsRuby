# frozen_string_literal: true

require 'yaml'
require_relative 'tour_data_base'
require_relative 'tour'
require_relative 'info'
require_relative 'tourist_data_base'
require_relative 'person'
# 1
module Input
  def self.need_num(str)
    loop do
      print str
      current = gets
      current = 'a' if current.to_i <= 0
      return nil if current == "\n"

      current = Float(current)
      return Integer(current)
    rescue ArgumentError => _exception
      puts 'This is not a number or number does not fit in the context of the program, try again'
    end
  end

  def self.need_parameter
    loop do
      print 'why parameter for print tour(price/country/landmark)>'
      line = gets
      line = line.chomp
      unless %w[price country landmark].include?(line)
        puts 'Invalid parameter'
        next
      end
      return line
    end
  end

  def self.need_type(str)
    loop do
      print str
      line = gets
      line = line.chomp
      unless %w[bus train plane motorship].include?(line)
        puts 'Invalid type'
        next
      end
      return line
    end
  end

  def self.need_string(str)
    loop do
      print str
      line = gets
      if line.nil?
        puts 'You have not entered anything,enter the required value'
        next
      end
      line = line.strip
      if line.empty?
        puts 'You have not entered anything,enter the required value'
        next
      end
      return line.chomp
    end
  end

  def self.read_filetours
    tdb = TourDB.new
    all_info = Psych.load_file('../data/tours.yaml')
    all_info.each do |tour|
      landmarks = tour['Landmark']
      duration = tour['Duration']
      price = tour['Price']
      num = tour['Num']
      info = Info.new(tour['Country'], tour['Type'])
      new_tour = Tour.new(info, duration, price, num, landmarks)
      tdb.push(new_tour)
    end
    tdb
  end

  def self.read_filetourists
    tdb = TouristDB.new
    all_info = Psych.load_file('../data/tourists.yaml')
    all_info.each do |tourist|
      landmark = tourist['Landmark']
      info = Info.new(tourist['Country'], tourist['Type'])
      person = Person.new(tourist['Name'], tourist['Surname'], tourist['Patronymic'])
      pricemin = tourist['Pricemin']
      pricemax = tourist['Pricemax']
      pricemin, pricemax = pricemax, pricemin if pricemin > pricemax
      new_tourist = Tourist.new(info, person, landmark, pricemin, pricemax)
      tdb.push(new_tourist)
    end
    tdb
  end
end
