# frozen_string_literal: true

require_relative 'utility_bill'

class UtilityBillDataBase
  def initialize(utility_bill_data_base = [])
    @utility_bill_data_base = utility_bill_data_base
  end

  def add(utility_bill)
    @utility_bill_data_base.push(utility_bill)
  end

  def utility_bill(index)
    @utility_bill_data_base[index.to_i]
  end

  def size
    @utility_bill_data_base.size
  end

  # def sort
  # @tourist_db.sort_by { |tourist| tourist.fio.surname }
  # end

  def remove(index)
    @utility_bill_data_base.delete_at(index.to_i - 1)
  end

  def each_with_index
    @utility_bill_data_base.each_with_index { |ut_bill, index| yield(ut_bill, index) }
  end

  def each
    @utility_bill_data_base.each { |ut_bill| yield(ut_bill) }
  end

  def empty
    return true if @utility_bill_data_base.empty?
  end

  def index(elm)
    @utility_bill_data_base.index(elm)
  end

  def group(name, surname, patronymic)
    group_db = []
    @utility_bill_data_base.each do |ut_bill|
      if ut_bill.fio.name == name && ut_bill.fio.surname == surname && ut_bill.fio.patronymic == patronymic
        group_db << ut_bill
      end
    end
    group_db.sort_by(&:type)
  end

  def sort_by_surname
    sort_db = []
    @utility_bill_data_base.each do |ut_bill|
      check = 0
      sort_db.each do |ut_bill1|
        if ut_bill1.fio.gen_str == ut_bill.fio.gen_str
          check = 1 if ut_bill1.type == ut_bill.type
        end
      end
      sort_db << ut_bill if ut_bill.pay_am.to_i > ut_bill.paid && check.zero?
    end
    sort_db.sort_by { |elm| elm.fio.surname }
  end
end
