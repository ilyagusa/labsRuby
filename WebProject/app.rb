# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/utility_bill'
require_relative 'lib/utility_bill_data_base'
require_relative 'lib/person'
require_relative 'lib/address'
require_relative 'lib/command'
require_relative 'lib/input'


configure do
  set :ut_bills_db, Input.read_file_ut_bills()
end

get '/' do
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
    redirect('/show_utb')
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
    redirect('/show_utb')
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
    redirect('/show_utb')
  else
    erb :paid
  end
end

get '/ut_bills_for_person' do
  erb :ut_bills_for_person
end

post '/ut_bills_for_person' do
  @ut_bills_db = UtilityBillDataBase.new
  settings.ut_bills_db.each do |ut_bill|
    if params['name'] == ut_bill.fio.name && params['surname'] == ut_bill.fio.surname
      @ut_bills_db.add(ut_bill) if params['patronymic'] == ut_bill.fio.patronymic
    end
  end
  if @ut_bills_db.empty
    @errors = 'Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)'
    erb :ut_bills_for_person
  else
    erb :show_utb
  end
end

get '/group_by_type' do
  erb :group_by_type
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
  erb :person_and_type
end

post '/person_and_type' do
  ut_bill = Command.solo_bills(params['name'], params['surname'], params['pat'], params['type'], settings.ut_bills_db)
  if ut_bill.nil?
    @errors = " Не найдено ни одного счёта(#{params['type']}) для данного человека(Все поля должны быть заполнены)"
    erb :person_and_type
  else
    settings.ut_bills_db.add(ut_bill)
    redirect('/show_utb')
  end
end

get '/show_statistic' do
  redirect('show_utb') if settings.ut_bills_db.empty
  @hash_stat = Command.statistic(settings.ut_bills_db)
  erb :show_statistic
end

get '/pay_am_month' do
  erb :type_month_payment
end

post '/pay_am_month' do
  @ut_bills_db = settings.ut_bills_db
  person_data_base = []
  @pay_month_data_base = Command.month_pay(params['month'], params['type'], @ut_bills_db, person_data_base)
  erb :show_pay_month
end
