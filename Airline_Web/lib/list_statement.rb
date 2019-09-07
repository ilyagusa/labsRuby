# frozen_string_literal: true

# creating list of statement
class ListStatement
  def initialize
    @list = []
  end

  def add(statement)
    @list << statement
  end

  def each
    @list.each { |_statement| yield flight }
  end

  def get_statement(index)
    @list[index.to_i]
  end

  def size
    @list.size
  end

  def each_with_index
    @list.each_with_index { |statement, index| yield statement, index }
  end

  def remove(index)
    @list.delete_at(index.to_i)
  end

  def delete_by_air(dep, air)
    @list.each_with_index do |flight, index|
      @list.delete_at(index.to_i) if flight.departure_airport == dep && flight.arrival_airport == air
    end
  end
end
