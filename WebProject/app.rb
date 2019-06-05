# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/utility_bill'
require_relative 'lib/utility_bill_data_base'
require_relative 'lib/person'

configure do
  set :ut_bills_db, UtilityBillDataBase.new([
                                              # fio, address, payment_amount, type, month
                                              UtilityBills.new(Person.new('Gusev', 'Ilya', 'Sergeevich'), 'Shopsha', '5000', 'hata', '12'),
                                              UtilityBills.new(Person.new('Kochigina', 'Anna', 'Mikhailovna'), 'Shopsha', '3000', 'hata', '2'),
                                              UtilityBills.new(Person.new('Travnikov', 'Andrey', 'Grigorevich'), 'Zayachii holm', '2000', 'hata', '4')
                                            ])
end

get '/' do
  @ut_bills_db = settings.ut_bills_db
  erb :main
end

get '/main' do
  @ut_bills_db = settings.ut_bills_db
  erb :show_utb
end

get '/show_utb' do
  @ut_bills_db = settings.ut_bills_db
  erb :show_utb
end

get '/add_ut_bill' do
  erb :add_ut_bill
end
