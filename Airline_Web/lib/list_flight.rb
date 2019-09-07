# frozen_string_literal: true

# creating list of flight
class ListFlight
  def initialize
    @list = []
  end

  def add(flight)
    @list << flight
  end

  def each
    @list.each { |flight| yield flight }
  end

  def get_flight(index)
    @list[index.to_i]
  end

  def size
    @list.size
  end

  def each_with_index
    @list.each_with_index { |flight, index| yield flight, index }
  end

  def remove(index)
    @list.delete_at(index.to_i)
  end
end
