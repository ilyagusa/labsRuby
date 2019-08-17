# frozen_string_literal: true

module Notebook
  # incapsulates notebook
  class Notebook
    def initialize
      @list = []
    end

    def add(person)
      @list.push(person)
    end

    def remove(index)
      return if index.to_i < 0 || index.to_i - 1 > @list.size

      @list.delete_at(Integer(index.to_i))
    end

    def change_address(index, new_address)
      return if index < 1 || index - 1 > @list.size

      @list[index - 1].address = new_address
    end

    def change_phone(index, new_phone)
      return if index < 1 || index - 1 > @list.size

      @list[index - 1].cell_phone = new_phone
    end

    def change_status(index, new_status)
      return if index < 1 || index - 1 > @list.size

      @list[index - 1].status = new_status
    end

    def event(status)
      invited = []
      @list.each do |person|
        invited.push(person) if person.status == status
      end
      invited
    end

    def each
      @list.each { |person| yield(person) }
    end

    def each_with_index
      @list.each_with_index { |person, index| yield(person, index) }
    end
  end
end
