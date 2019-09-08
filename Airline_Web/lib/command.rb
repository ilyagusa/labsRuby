# frozen_string_literal: true

require_relative 'flight'
require_relative 'statement'
require_relative 'list_flight'
require_relative 'list_statement'

# This module contains functions responsible for the creation of statistics and other data lists
module Command
  def self.flight_for_param(f_db, s_db, index)
    f_db_for_stat = ListFlight.new
    st = s_db.get_statement(index.to_i)
    date_st = st.date_departure.split('.')
    f_db.each do |flight|
      date_flight = flight.date_departure.split('.')
      next unless flight.departure_airport == st.departure_airport && flight.arrival_airport == st.arrival_airport &&
                  date_st[2].to_i == date_flight[2].to_i &&
                  ((date_st[0].to_i + date_st[1].to_i * 31) <= (date_flight[0].to_i + date_flight[1].to_i * 31) + 2) &&
                  ((date_st[0].to_i + date_st[1].to_i * 31) >= (date_flight[0].to_i + date_flight[1].to_i * 31) - 2)

      f_db_for_stat.add(flight)
    end
    f_db_for_stat
  end
end
