# frozen_string_literal: true

require 'spec_helper'
require 'capybara/rspec'

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Проверка контента при переходе к /' do
    visit('/main')
    expect(page).to have_content('Работа с рейсами и заявками')
  end

  it 'Тест на добавление рейса' do
    visit('/')
    click_on('Добавить рейс')
    fill_in('dep_air', with: 'a')
    fill_in('arr_air', with: 'b')
    fill_in('day_dep', with: '5')
    fill_in('month_dep', with: '12')
    fill_in('year_dep', with: '2018')
    fill_in('hour_dep', with: '12')
    fill_in('min_dep', with: '40')
    fill_in('day_arr', with: '5')
    fill_in('month_arr', with: '12')
    fill_in('year_arr', with: '2018')
    fill_in('hour_arr', with: '13')
    fill_in('min_arr', with: '50')
    select('Боинг-542', from: 'type')
    fill_in('cost', with: '7897')
    fill_in('num_id', with: '52')
    click_on('Добавление')
    expect(page).to have_content('7897')
    click_on('Добавить рейс')
    click_on('Добавление')
    expect(page).to have_content('Здесь должно быть число 0<=x<=60')
  end

  it 'Тест на добавление заявки' do
    visit('/')
    click_on('Добавить заявку')
    fill_in('surname', with: 'ilya')
    fill_in('name', with: 'c')
    fill_in('dep_air', with: 'a')
    fill_in('arr_air', with: 'b')
    fill_in('day_dep', with: '25')
    fill_in('month_dep', with: '12')
    fill_in('year_dep', with: '2018')
    fill_in('hour_dep', with: '5')
    fill_in('min_dep', with: '12')
    fill_in('id', with: '125')
    click_on('Добавить')
    expect(page).to have_content('ilya')
    click_on('Добавить заявку')
    click_on('Добавить')
    expect(page).to have_content('Здесь не должно быть пусто')
  end

  it 'Тест на удаление рейса/заявки' do
    visit('/show_statement')
    name = find_by_id('name', match: :first).text
    surname = find_by_id('surname', match: :first).text
    find_button('Удалить', match: :first).click
    expect(page).not_to have_content(include(name).and(include(surname)))
  end

  it 'Тест на удаление рейса/заявки' do
    visit('/show_flight')
    cost = find_by_id('cost', match: :first).text
    type = find_by_id('type', match: :first).text
    find_button('Удалить', match: :first).click
    expect(page).not_to have_content(include(cost).and(include(type)))
  end

  it 'Тест на удаление заявок по пунктам назначения/отправления' do
    visit('/delete_stat_by_parameter')
    fill_in('dep_air', with: 'Ставрополь')
    fill_in('arr_air', with: 'Иваново')
    click_on('Удалить')
    expect(page).not_to have_content(include('Ставрополь').and(include('Иваново')))
  end

  it 'Тест на вывод рейсов по параметру' do
    visit('/show_flight_by_parameter')
    fill_in('dep_air', with: '5')
    fill_in('arr_air', with: '12')
    fill_in('day_dep', with: '25')
    fill_in('month_dep', with: '12')
    fill_in('year_dep', with: '2018')
    click_on('Показать')
    expect(page).to have_content('Список рейсов по назначенным параметрам')
    visit('/show_flight_by_parameter')
    click_on('Показать')
    expect(page).to have_content('Здесь не должно быть пусто')
  end

  it 'Тест на  вывод заявок по дате' do
    visit('/show_statement_by_parameter')
    fill_in('day_dep', with: '25')
    fill_in('month_dep', with: '12')
    fill_in('year_dep', with: '2018')
    fill_in('hour_dep', with: '5')
    fill_in('min_dep', with: '12')
    click_on('Вывести заявки')
  end

  it 'Тест на поиск рейсов' do
    visit('/show_statement')
    find_button('Найти рейсы', match: :first).click
    expect(page).to have_content('Рейсов для данной заявки не найдено')
  end
end
