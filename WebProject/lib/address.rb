# frozen_string_literal: true

# This This class is responsible for the address
class Address
  attr_accessor :city, :street, :house, :apartment
  def initialize(city, street, house, apartment)
    @city = city
    @street = street
    @house = house
    @apartment = apartment
  end

  def full_adr
    "#{@city} + #{@street} + #{@house} + #{@apartment}"
  end
end
