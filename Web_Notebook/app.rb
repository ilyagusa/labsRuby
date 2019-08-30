# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/person'
require_relative 'lib/notebook'
require_relative 'lib/input'
require_relative 'lib/commands'

configure do
  set :notebook, Input.read_file
end

get '/' do
  @notebook = settings.notebook
  erb :show_person
end

get '/main' do
  @notebook = settings.notebook
  erb :show_person
end

get '/add_person' do
  erb :add_person
end

post '/add_person' do
  date = '' + params['day'] + '.' + params['month'] + '.' + params['year']
  address = '' + params['street'] + ' ' + params['house']
  @person = Person.new(params['name'], params['surname'], params['patronymic'], params['gender'],
                       date, params['cell'], params['home'], address, params['status'])
  @errors = @person.check_error
  @errors[:negative_year] = 'В этом поле должно быть число > 0' if params['year'].to_i <= 0 || params['year'].empty?
  @errors[:negative_house] = 'В этом поле должно быть число > 0' if params['house'].to_i <= 0 || params['house'].empty?
  @errors[:space_street] = 'Это поле не должно быть пустым' if params['street'].empty?
  if @errors.empty?
    settings.notebook.add(@person)
    redirect('/')
  else
    erb :add_person
  end
end

get '/delete_person' do
end

post '/delete_person' do
  settings.notebook.remove(params['index'])
  redirect('/main')
end

get '/edit_status/:index' do
  @person = settings.notebook.pers(params['index'])
  erb :edit_status
end

post '/edit_status/:index' do
  @person = settings.notebook.pers(params['index'])
  @errors = {}
  if @errors.empty?
    settings.notebook.change_status(params['index'], params['status'])
    redirect('/main')
  else
    erb :edit_status
  end
end

get '/edit_address/:index' do
  @person = settings.notebook.pers(params['index'])
  erb :edit_address
end

post '/edit_address/:index' do
  address = '' + params['street'] + ' ' + params['house']
  @person = settings.notebook.pers(params['index'])
  @person = settings.notebook.pers(params['index'])
  @errors = {}
  @errors[:negative_house] = 'В этом поле должно быть число >0' if params['house'].to_i <= 0 || params['house'].empty?
  @errors[:space_street] = 'Это поле не должно быть пустым' if params['street'].empty?
  if @errors.empty?
    settings.notebook.change_address(params['index'], address)
    redirect('/main')
  else
    erb :edit_address
  end
end

get '/edit_cell/:index' do
  @person = settings.notebook.pers(params['index'])
  erb :edit_cell
end

post '/edit_cell/:index' do
  @person = settings.notebook.pers(params['index'])
  @errors = {}
  @errors[:space_cell] = 'В этом поле должно быть число >0' if params['cell'].empty? || params['cell'].to_i <= 0
  if @errors.empty?
    settings.notebook.change_phone_cell(params['index'], params['cell'])
    redirect('/main')
  else
    erb :edit_cell
  end
end

get '/edit_home/:index' do
  @person = settings.notebook.pers(params['index'])
  erb :edit_home
end

post '/edit_home/:index' do
  @person = settings.notebook.pers(params['index'])
  @errors = {}
  @errors[:space_home] = 'В этом поле должно быть число >0' if params['home'].empty? || params['home'].to_i <= 0
  if @errors.empty?
    settings.notebook.change_phone_home(params['index'], params['home'])
    redirect('/main')
  else
    erb :edit_home
  end
end

get '/birthday' do
  erb :birthday
end

post '/birthday' do
  @mass_birthday = settings.notebook.birthday(params['month'], params['day'])
  erb :birthday_show
end

get '/event' do
  erb :event
end

post '/event' do
  Commands.event(settings.notebook, params['event'], params['status'], params['mes'])

  redirect('/main')
end
