# frozen_string_literal: true

# 1
class Person
  attr_accessor :name, :surname, :patronymic
  def initialize(name, surname, patronymic)
    @name = name
    @surname = surname
    @patronymic = patronymic
  end

  def to_s
    "Name:#{@name} Surname:#{@surname} Patronymic:#{@patronymic}"
  end
end
