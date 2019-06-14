# frozen_string_literal: true

require 'yaml'
require_relative 'utility_bill_data_base'
require_relative 'utility_bill'
require_relative 'address'
require_relative 'person'
# This class is responsible for reading from a file
module Input
  FILE_UTBILLS = File.expand_path('../data/ut_bills.yaml', __dir__)
  def self.read_file_ut_bills
    ut_bills_db = UtilityBillDataBase.new
    exit unless File.exist?(FILE_UTBILLS)
    all_info = Psych.load_file(FILE_UTBILLS)
    all_info.each do |ut_bill|
      pay_amount = ut_bill['Payment_amount']
      month = ut_bill['Month']
      type = ut_bill['Type']
      address = Address.new(ut_bill['City'], ut_bill['Street'], ut_bill['House'], ut_bill['Apartment'])
      fio = Person.new(ut_bill['Surname'], ut_bill['Name'], ut_bill['Patronymic'])
      new_ut_bill_db = UtilityBills.new(fio, address, pay_amount, type, month)
      ut_bills_db.add(new_ut_bill_db)
    end
    ut_bills_db
  end
end
