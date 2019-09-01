# frozen_string_literal: true

# incapsulates notebook
class Notebook
  def initialize
    @list = []
  end

  def pers(index)
    @list[index.to_i]
  end

  def add(person)
    @list.push(person)
  end

  def remove(index)
    return if index.to_i.negative? || index.to_i - 1 > @list.size

    @list.delete_at(Integer(index.to_i))
  end

  def change_address(index, new_address)
    return if index.to_i.negative? || index.to_i - 1 > @list.size

    @list[index.to_i].address = new_address
  end

  def change_phone_cell(index, new_phone)
    return if index.to_i.negative? || index.to_i - 1 > @list.size

    @list[index.to_i].cell_phone = new_phone
  end

  def change_phone_home(index, new_phone)
    return if index.to_i.negative? || index.to_i - 1 > @list.size

    @list[index.to_i].home_phone = new_phone
  end

  def change_status(index, new_status)
    return if index.to_i.negative? || index.to_i - 1 > @list.size

    @list[index.to_i].status = new_status
  end

  def event(status)
    invited = []
    @list.each do |person|
      invited.push(person) if person.status == status
    end
    invited
  end

  def each_with_index
    @list.each_with_index { |person, index| yield(person, index) }
  end

  def birthday(month, day)
    bd_base = []
    help_base = []
    mass = []
    @list.each_with_index do |person, _index|
      arr = person.date.split('.')
      difference = (month.to_i * 30 + day.to_i) - (arr[0].to_i + arr[1].to_i * 30)
      bd_base << difference.abs
      help_base << difference.abs
    end
    id = bd_base.index(bd_base.min)
    mass << @list[id.to_i]
    bd_base.delete_at(id.to_i)
    id = help_base.index(bd_base.min)
    mass << @list[id.to_i]
    mass
  end
end
