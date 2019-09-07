# frozen_string_literal: true

# creating one flight
class Flight
  attr_accessor :departure_airport, :arrival_airport, :number, :time_departure,
                :time_arrival, :cost, :date_arrival, :date_departure, :type

  def initialize(departure_airport, arrival_airport, number, time_departure,
                 time_arrival, date_departure, date_arrival, cost, type)
    @departure_airport = departure_airport
    @arrival_airport = arrival_airport
    @number = number.to_i
    @time_departure = time_departure
    @time_arrival = time_arrival
    @date_departure = date_departure
    @date_arrival = date_arrival
    @cost = cost.to_i
    @type = type
  end

  def check_field
    errors = {}

    message_empty = 'Поле не должно быть пустым'
    message_negative = 'Число должно быть >=1!'

    check_empty1(errors, message_empty)
    check_empty2(errors, message_empty)
    check_negative(errors, message_negative)
    errors
  end

  def check_empty1(errors, message)
    errors[:departure_airport] = message if @departure_airport.empty?
    errors[:arrival_airport] = message if @arrival_airport.empty?
    errors[:time_departure] = message if @time_departure.empty?
  end

  def check_empty2(errors, message)
    errors[:time_arrival] = message if @time_arrival.empty?
    errors[:date_arrival] = message if @date_arrival.empty?
    errors[:date_departure] = message if @date_departure.empty?
  end

  def check_negative(errors, message)
    errors[:number_neg] = message if @number.to_i < 1
    errors[:cost_neg] = message if @cost.to_i < 1
  end
end
