# frozen_string_literal: true

# 1
class Person
  attr_accessor :name, :surname, :patronymic
  def initialize(surname, name, patronymic)
    @name = name
    @surname = surname
    @patronymic = patronymic
  end

  def to_s
    "Surname:#{@surname} Name:#{@name}  Patronymic:#{@patronymic}"
  end
end
