# frozen_string_literal: true

# This class describes a person(name,surname,patronymic)
class Person
  attr_accessor :name, :surname, :patronymic
  def initialize(surname, name, patronymic)
    @name = name
    @surname = surname
    @patronymic = patronymic
  end

  def check_space
    return true if @name.empty? || @surname.empty? || @patronymic.empty?
  end

  def gen_str
    "#{@name} #{@surname} ##{@patronymic}"
  end
end
