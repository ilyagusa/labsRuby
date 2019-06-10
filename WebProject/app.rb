# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/utility_bill'
require_relative 'lib/utility_bill_data_base'
require_relative 'lib/person'
require_relative 'lib/address'
require_relative 'lib/command'


configure do
  set :ut_bills_db, UtilityBillDataBase.new([
                                              # fio, address, payment_amount, type, month
                                              UtilityBills.new(Person.new('Gusev', 'Ilya', 'Sergeevich'), Address.new('Shopsha', 'molod', 15, 4), '5000', 'Квартплата', '12'),
                                              UtilityBills.new(Person.new('Kochigina', 'Anna', 'Mikhailovna'), Address.new('Shopsha', 'molod', 15, 4), '3000', 'phone', '2'),
                                              UtilityBills.new(Person.new('Travnikov', 'Andrey', 'Grigorevich'), Address.new('Dubna', 'molod', 32, 123), '2000', 'gaz', '4'),
                                              UtilityBills.new(Person.new('Gusev', 'Ilya', 'Sergeevich'), Address.new('Shopsha', 'molod', 43, 4), '2800', 'Квартплата', '7'),
                                              UtilityBills.new(Person.new('Gusev', 'Ilya', 'Sergeevich'), Address.new('Shopsha', 'molod', 213, 3), '3700', 'Квартплата', '10'),

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
  @ut_bill = UtilityBills.new(person, address, params['pay_am'], params['type'], params['month'])
  @ut_bill.check_error
  @errors = @ut_bill.errors
  if @errors.empty?
    settings.ut_bills_db.add(@ut_bill)
    redirect('/main')
  else
    erb :add_ut_bill
  end
end

get '/delete_ut_bill' do
  erb :delete_ut_bill
end

post '/delete_ut_bill' do
  @errors = 'Число должно быть больше 0 и меньше максимального номера счёта'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.ut_bills_db.size
    settings.ut_bills_db.remove(params['index'])
    redirect('/main')
  else
    erb :delete_ut_bill
  end
end

get '/paid/:index' do
  @ut_bill = settings.ut_bills_db.utility_bill(params['index'])
  erb :paid
end

post '/paid/:index' do
  @ut_bill = settings.ut_bills_db.utility_bill(params['index'])
  @errors = "Оплата должна быть больше 0 , но не больше #{@ut_bill.pay_am.to_i - @ut_bill.paid.to_i}(Остаток оплаты)"
  if params['paid'].to_i.positive? && params['paid'].to_i <= (@ut_bill.pay_am.to_i - @ut_bill.paid.to_i)
    @ut_bill.paid += params['paid'].to_i
    settings.ut_bills_db.utility_bill(params['index']).paid = @ut_bill.paid.to_i
    redirect('/main')
  else
    erb :paid
  end
end

get '/ut_bills_for_person' do
  @ut_bills_db = UtilityBillDataBase.new
  erb :ut_bills_for_person
end

post '/ut_bills_for_person' do
  @ut_bills_db = UtilityBillDataBase.new
  settings.ut_bills_db.each do |ut_bill|
    if params['name'] == ut_bill.fio.name && params['surname'] == ut_bill.fio.surname
      @ut_bills_db.add(ut_bill) if params['patronymic'] == ut_bill.fio.patronymic
    end
  end
  @errors = 'Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)' if @ut_bills_db.empty
  erb:ut_bills_for_person
end

get '/group_by_type' do
  erb:group_by_type
end

post '/group_by_type' do
  @ut_bills_db = settings.ut_bills_db.group(params['name'], params['surname'], params['patronymic'])
  if @ut_bills_db.empty?
    @errors = 'Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)'
    erb :group_by_type
  else
    erb :show_money
  end
end

get '/show_debt' do
  @debt_db = settings.ut_bills_db.sort_by_surname
  erb :show_debt
end

get '/person_and_type' do
  erb:person_and_type
end

post '/person_and_type' do
  ut_bill=Command.general_bill(params['name'],params['surname'],params['pat'],params['type'],settings.ut_bills_db)
  settings.ut_bills_db.add(ut_bill)
  redirect('/main')
end