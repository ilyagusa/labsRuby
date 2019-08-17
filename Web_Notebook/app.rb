# frozen_string_literal: true


require 'sinatra'
require_relative 'lib/person'
require_relative 'lib/notebook'
require_relative 'lib/input'
require_relative 'lib/commands'

include Notebook
include Input
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
    date =  '' + params['day'] + '.' + params['month'] + '.' + params['year']
    address = '' + params['street'] + ' ' + params['house']
    @person = Person.new(params['name'],params['surname'],params['patronymic'], params['gender'],
    date, params['cell'], params['home'], address, params['status'])
    @errors=@person.check_error
    @errors[:negative_year] = 'В этом поле должно быть положительное число' if params['year'].to_i <= 0 || params['year'].empty?
    @errors[:negative_house] = 'В этом поле должно быть положительное число' if params['house'].to_i <=0 || params['house'].empty?
    @errors[:space_street] = 'Это поле не должно быть пустым' if params['street'].empty?
    if @errors.empty?
     settings.notebook.add(@person)
     redirect('/')
    else 
        erb:add_person
    end
end


get '/delete_person' do
end

post '/delete_person' do
  settings.notebook.remove(params['index'])
  redirect('/main')
end
