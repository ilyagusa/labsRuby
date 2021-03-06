# frozen_string_literal: true

require_relative 'tourist'
# 1
class TouristDB
  def initialize
    @tourist_db = []
  end

  def push(tourist)
    @tourist_db.push(tourist)
  end

  def tourist(index)
    @tourist_db[index]
  end

  def size
    @tourist_db.size
  end

  def sort
    @tourist_db.sort_by { |tourist| tourist.fio.surname }
  end

  def remove(index)
    @tourist_db.delete_at(index)
  end

  def each_with_index
    @tourist_db.each_with_index { |tourist, index| yield(tourist, index) }
  end

  def swapocc
    @tourist_db.each { |tourist| tourist.occupancy = true }
  end

  def to_s
    str = ''
    @tourist_db.each_with_index { |value, index| str += "#{index + 1} TOURIST:#{value}\n\n" }
    str
  end
end
