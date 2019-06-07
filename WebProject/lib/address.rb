# frozen_string_literal: true

class Address
  attr_reader :city, :street, :house, :apartment
  def initialize(city, street, house, apartment)
    @city = city
    @street = street
    @house = house
    @apartment = apartment
  end

  def to_s
    "\nНП:#{@city} ул.#{@street} д.#{@house} кв.#{@apartment}"
  end
end
