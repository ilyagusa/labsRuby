# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/utility_bill'
require_relative 'lib/utility_bill_data_base'
require_relative 'lib/person'
require_relative 'lib/address'

configure do
  set :ut_bills_db, UtilityBillDataBase.new([
                                              # fio, address, payment_amount, type, month
                                              UtilityBills.new(Person.new('Gusev', 'Ilya', 'Sergeevich'), Address.new('Shopsha', 'molod', 15, 4), '5000', 'hata', '12'),
                                              UtilityBills.new(Person.new('Kochigina', 'Anna', 'Mikhailovna'), Address.new('Shopsha', 'molod', 15, 4), '3000', 'phone', '2'),
                                              UtilityBills.new(Person.new('Travnikov', 'Andrey', 'Grigorevich'), Address.new('Dubna', 'molod', 32, 123), '2000', 'gaz', '4')
                                            ])
end

get '/' do
  @ut_bills_db = settings.ut_bills_db
  erb :show_utb
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

post '/add_ut_bill' do
  address = Address.new(params['city'], params['street'], params['house'], params['apartment'])
  person = Person.new(params['surname'], params['name'], params['patronymic'])
  ut_bill = UtilityBills.new(person, address, params['pay_am'], params['type'], params['month'])
  ut_bill.check_error
  if ut_bill.errors.empty?
    settings.ut_bills_db.add(ut_bill)
    redirect('/main')
  else
    erb :add_ut_bill
  end
end

get '/delete_ut_bill' do
  erb :delete_ut_bill
end

post '/delete_ut_bill' do
  settings.ut_bills_db.remove(params['index'])
  redirect('/main')
end
