# frozen_string_literal: true

# creating one Statement
class Statement
  attr_accessor :departure_airport, :arrival_airport, :id, :time_departure, :date_departure, :name, :surname

  def initialize(departure_airport, arrival_airport, id, time_departure, date_departure, name, surname)
    @name = name
    @surname = surname
    @departure_airport = departure_airport
    @arrival_airport = arrival_airport
    @id = id.to_i
    @time_departure = time_departure
    @date_departure = date_departure
  end

  def check_field
    errors = {}

    message_empty = 'This field cannot be empty!'
    message_negative = 'Number < 0!'

    check_empty1(errors, message_empty)
    check_empty2(errors, message_empty)
    check_negative(errors, message_negative)

    errors
  end

  def check_empty1(errors, message)
    errors[:name] = message if @name.empty?
    errors[:surname] = message if @surname.empty?
    errors[:departure_airport] = message if @departure_airport.empty?
  end

  def check_empty2(errors, message)
    errors[:arrival_airport] = message if @arrival_airport.empty?
    errors[:time_departure] = message if @time_departure.empty?
    errors[:date_departure] = message if @date_departure.empty?
  end

  def check_negative(errors, message)
    errors[:id] = message if @id.negative?
  end
end
