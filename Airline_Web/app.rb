# frozen_string_literal: true

require 'sinatra'

require_relative 'lib/flight'
require_relative 'lib/list_flight'
require_relative 'lib/statement'
require_relative 'lib/list_statement'
require_relative 'lib/input'
require_relative 'lib/command'

configure do
  set :flight_db, Input.read_file_flight
  set :statement_db, Input.read_file_statement
end

get '/' do
  erb :main
end

get '/main' do
  erb :main
end

get '/show_flight' do
  @flight_db = settings.flight_db
  erb :show_flight
end

get '/delete_flight' do
end

post '/delete_flight' do
  settings.flight_db.remove(params['index'])
  redirect('/show_flight')
end

get '/show_statement' do
  @statement_db = settings.statement_db
  erb :show_statement
end

get '/delete_statement' do
end

post '/delete_statement' do
  settings.statement_db.remove(params['index'])
  redirect('/show_statement')
end

get '/add_flight' do
  erb :add_flight
end

post '/add_flight' do
  h = 'Здесь должно быть число 0<=x<=24'
  m = 'Здесь должно быть число 0<=x<=60'
  d = 'Здесь должно быть число от 1 до 31 '
  mo = 'Здесь должно быть число от 1 до 12 '
  time_dep = '' + params['hour_dep'] + ':' + params['min_dep']
  time_arr = '' + params['hour_arr'] + ':' + params['min_arr']
  date_dep = '' + params['day_dep'] + '.' + params['month_dep'] + '.' + params['year_dep']
  date_arr = '' + params['day_arr'] + '.' + params['month_arr'] + '.' + params['year_arr']
  flight = Flight.new(params['dep_air'], params['arr_air'], params['num_id'],
                      time_dep, time_arr, date_dep, date_arr, params['cost'], params['type'])
  @errors = flight.check_field
  @errors[:day_dep] = d if params['day_dep'].to_i < 1 || params['day_dep'].to_i > 31
  @errors[:day_arr] = d if params['day_arr'].to_i < 1 || params['day_arr'].to_i > 31
  @errors[:month_dep] = mo if params['month_dep'].to_i < 1 || params['month_dep'].to_i > 12
  @errors[:month_arr] = mo if params['month_arr'].to_i < 1 || params['month_arr'].to_i > 12
  @errors[:min_arr] = m if params['min_arr'].to_i.negative? || params['min_arr'].to_i > 60 || params['min_arr'].empty?
  @errors[:min_dep] = m if params['min_dep'].to_i.negative? || params['min_dep'].to_i > 60 || params['min_dep'].empty?
  @errors[:h_arr] = h if params['hour_arr'].to_i.negative? || params['hour_arr'].to_i > 60 || params['hour_arr'].empty?
  @errors[:h_dep] = h if params['hour_dep'].to_i.negative? || params['hour_dep'].to_i > 60 || params['hour_dep'].empty?
  @errors[:year] = 'Неподходящий год' if params['year_dep'].to_i < 2012 || params['year_arr'].to_i < 2012
  if @errors.empty?
    settings.flight_db.add(flight)
    redirect('/show_flight')
  end
  erb :add_flight
end

get '/add_statement' do
  erb :add_statement
end

post '/add_statement' do
  @errors = {}
  t_d = '' + params['hour_dep'] + ':' + params['min_dep']
  d_d = '' + params['day_dep'] + '.' + params['month_dep'] + '.' + params['year_dep']
  h = 'Здесь должно быть число 0<=x<=24'
  m = 'Здесь должно быть число 0<=x<=60'
  d = 'Здесь должно быть число от 1 до 31 '
  mo = 'Здесь должно быть число от 1 до 12 '
  st = Statement.new(params['dep_air'], params['arr_air'], params['id'], t_d, d_d, params['name'], params['surname'])
  @errors = st.check_field
  @errors[:min_dep] = m if params['min_dep'].to_i.negative? || params['min_dep'].to_i > 60 || params['min_dep'].empty?
  @errors[:h_dep] = h if params['hour_dep'].to_i.negative? || params['hour_dep'].to_i > 60 || params['hour_dep'].empty?
  @errors[:year] = 'Неподходящий год' if params['year_dep'].to_i < 2012
  @errors[:month_dep] = mo if params['month_dep'].to_i < 1 || params['month_dep'].to_i > 12
  @errors[:day_dep] = d if params['day_dep'].to_i < 1 || params['day_dep'].to_i > 31
  @errors[:space] = 'Здесь не должно быть пусто' if params['name'].empty? || params['surname'].empty?
  if @errors.empty?
    settings.statement_db.add(st)
    redirect('/show_statement')
  end
  erb :add_statement
end

get '/delete_stat_by_parameter' do
  erb :delete_stat_air
end

post '/delete_stat_by_parameter' do
  dep = params['dep_air'].to_s
  arr = params['arr_air'].to_s
  @errors = {}
  @errors[:space] = 'Поле не должно быть пустым' if dep.empty? || arr.empty?
  if @errors.empty?
    settings.statement_db.delete_by_air(dep, arr)
    redirect('/show_statement')
  end
  erb:delete_stat_air
end

get '/show_flight_by_parameter' do
  erb:show_flight_by_param
end

post '/show_flight_by_parameter' do
  @flight_by_param = ListFlight.new
  @errors = {}
  d = 'Здесь должно быть число от 1 до 31 '
  mo = 'Здесь должно быть число от 1 до 12 '
  @errors[:space] = 'Здесь не должно быть пусто' if params['dep_air'].empty? || params['arr_air'].empty?
  @errors[:year] = 'Неподходящий год' if params['year_dep'].to_i < 2012
  @errors[:month_dep] = mo if params['month_dep'].to_i < 1 || params['month_dep'].to_i > 12
  @errors[:day_dep] = d if params['day_dep'].to_i < 1 || params['day_dep'].to_i > 31
  date_dep = '' + params['day_dep'] + '.' + params['month_dep'] + '.' + params['year_dep']
  settings.flight_db.each do |flight|
    @flight_by_param.add(flight) if flight.departure_airport == params['dep_air'] &&
                                    flight.arrival_airport == params['arr_air'] && flight.date_departure == date_dep
  end
  if @errors.empty?
    erb:show_flight_param
  else
    erb:show_flight_by_param
  end
end

get '/show_statement_by_parameter' do
  erb :show_statement_by_parameter
end

post '/show_statement_by_parameter' do
  @statement_by_param = ListStatement.new
  @errors = {}
  t_d = '' + params['hour_dep'] + ':' + params['min_dep']
  d_d = '' + params['day_dep'] + '.' + params['month_dep'] + '.' + params['year_dep']
  h = 'Здесь должно быть число 0<=x<=24'
  m = 'Здесь должно быть число 0<=x<=60'
  d = 'Здесь должно быть число от 1 до 31 '
  mo = 'Здесь должно быть число от 1 до 12 '
  @errors[:min_dep] = m if params['min_dep'].to_i.negative? || params['min_dep'].to_i > 60 || params['min_dep'].empty?
  @errors[:h_dep] = h if params['hour_dep'].to_i.negative? || params['hour_dep'].to_i > 60 || params['hour_dep'].empty?
  @errors[:year] = 'Неподходящий год' if params['year_dep'].to_i < 2012
  @errors[:month_dep] = mo if params['month_dep'].to_i < 1 || params['month_dep'].to_i > 12
  @errors[:day_dep] = d if params['day_dep'].to_i < 1 || params['day_dep'].to_i > 31
  settings.statement_db.each do |stat|
    @statement_by_param.add(stat) if stat.time_departure == t_d && stat.date_departure == d_d
  end
  if @errors.empty?
    erb :show_stat_param
  else
    erb :show_statement_by_parameter
  end
end

get '/flight_for_statement' do
end

post '/flight_for_statement' do
  @flight_for_statement = Command.flight_for_param(settings.flight_db, settings.statement_db, params['index'].to_i)
  @void = 'Рейсов для данной заявки не найдено' if @flight_for_statement.empty?
  erb :flight_for_statement
end
