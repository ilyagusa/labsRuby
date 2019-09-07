# frozen_string_literal: true

require 'yaml'
require_relative 'list_statement'
require_relative 'list_flight'
require_relative 'flight'
require_relative 'statement'
# This class is responsible for reading from a file
module Input
  FILE_FLIGHT = File.expand_path('../data/flight_db.yaml', __dir__)
  FILE_STATEMENT = File.expand_path('../data/statement_db.yaml', __dir__)

  def self.read_file_flight
    flight_db = ListFlight.new
    exit unless File.exist?(FILE_FLIGHT)
    all_info = Psych.load_file(FILE_FLIGHT)
    all_info.each do |flight|
      departure_airport = flight['departure_airport']
      arrival_airport = flight['arrival_airport']
      date_departure = flight['date_departure']
      date_arrival = flight['date_arrival']
      time_departure = flight['time_departure']
      time_arrival = flight['time_arrival']
      new_flight = Flight.new(departure_airport, arrival_airport, flight['id'], time_departure,
                              time_arrival, date_departure, date_arrival, flight['cost'], flight['type'])
      flight_db.add(new_flight)
    end
    flight_db
  end

  def self.read_file_statement
    statement_db = ListStatement.new
    exit unless File.exist?(FILE_STATEMENT)
    all_info = Psych.load_file(FILE_STATEMENT)
    all_info.each do |statement|
      id = statement['id']
      departure_airport = statement['departure_airport']
      arrival_airport = statement['arrival_airport']
      date_departure = statement['date_departure']
      time_departure = statement['time_departure']
      new_statement = Statement.new(departure_airport, arrival_airport, id, time_departure, date_departure,
                                    statement['name'], statement['surname'])
      statement_db.add(new_statement)
    end
    statement_db
  end
end
