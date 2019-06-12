# frozen_string_literal: true

require_relative 'person'
require_relative 'address'
require_relative 'utility_bill'
require_relative 'utility_bill_data_base'

module Command
  def self.general_bill(name, surname, patronymic, type, data_base)
    solo_data_base = []
    data_base.each_with_index do |ut_bill, _index|
      if ut_bill.fio.surname == surname && ut_bill.fio.name == name && ut_bill.fio.patronymic == patronymic
        solo_data_base << ut_bill if ut_bill.type == type
      end
    end
    solo_data_base.each do |elm|
      data_base.remove(data_base.index(elm) + 1)
    end
    solo_data_base
  end

  def self.solo_bills(name, surname, patronymic, type, data_base)
    solo_db = general_bill(name, surname, patronymic, type, data_base)
    return nil if solo_db.empty?

    solo_bill = solo_db[0]
    solo_db.each_with_index do |ut_bill, index|
      next if index.zero?

      solo_bill.paid += ut_bill.paid
      solo_bill.pay_am = solo_bill.pay_am.to_i + ut_bill.pay_am.to_i
      solo_bill.month = ut_bill.month if ut_bill.month.to_i > solo_bill.month.to_i
    end
    solo_bill
  end

  def self.uniq(data_base)
    sort_db = []
    data_base.each do |ut_bill|
      check = 0
      sort_db.each do |ut_bill1|
        check = 1 if ut_bill1.fio.gen_str == ut_bill.fio.gen_str
      end
      sort_db << ut_bill if check.zero?
    end
    sort_db.size
  end

  def self.avg_pay_am(data_base)
    avg_payment_amount = 0
    data_base.each do |ut_bill|
      avg_payment_amount += ut_bill.pay_am.to_i
    end
    avg_payment_amount / data_base.size
  end

  def self.avg_paid(data_base)
    average_paid = 0
    data_base.each do |ut_bill|
      average_paid += ut_bill.paid
    end
    average_paid / data_base.size
  end

  def self.most_common_type(data_base)
    hash_type = { 'Плата за телефон' => 0, 'Квартплата' => 0, 'Плата за электричество' => 0 }
    data_base.each do |ut_bill|
      hash_type['Квартплата'] += 1 if ut_bill.type == 'Квартплата'
      hash_type['Плата за телефон'] += 1 if ut_bill.type == 'Плата за телефон'
      hash_type['Плата за электричество'] += 1 if ut_bill.type == 'Плата за электричество'
    end
    max = 0
    hash_type.each do |_key, value|
      max = value if value > max
    end
    hash_type.index(max)
  end

  def self.avg_pay_am_for_type(data_base, type_most)
    avg_pay = 0
    count = 0
    data_base.each do |ut_bill|
      if ut_bill.type == type_most
        avg_pay += ut_bill.pay_am.to_i
        count += 1
      end
    end
    avg_pay / count
  end

  def self.statistic(data_base)
    stat = {}
    stat[:uniq_person] = uniq(data_base)
    stat[:avg_pay_am] = avg_pay_am(data_base)
    stat[:avg_paid] = avg_paid(data_base)
    stat[:most_common_type] = most_common_type(data_base)
    stat[:avg_pay_am_for_type] = avg_pay_am_for_type(data_base, most_common_type(data_base))
    stat
  end

  def self.month_pay(month, type, data_base, person_data_base)
    delete_base = []
    data_base.each do |ut_bill|
      check = 0
      person_data_base.each do |person|
        check = 1 if person.gen_str == ut_bill.fio.gen_str
      end
      person_data_base << ut_bill.fio if check.zero?
      delete_base << ut_bill.fio if ut_bill.month.to_i == month.to_i && ut_bill.type == type
    end
    delete_base.each do |elm|
      person_data_base.each_with_index do |person, index|
        person_data_base.delete_at(index) if person.gen_str == elm.gen_str
      end
    end
    person_data_base
  end
end
