# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Проверка присутствия контента' do
    visit('/')
    expect(page).to have_content('Список контактов')
  end

  it 'Тест на вывод дней рождения' do
    visit('/birthday')
    select('5', from: 'month')
    select('5', from: 'day')
    click_on('Показать ближайшие дни рождения')
    expect(page).to have_content('Ближайшие дни рождения')
  end

  it 'Тест на удаление контакта' do
    visit('/main')
    cell = find_by_id('cell', match: :first).text
    find_button('Удалить', match: :first).click
    expect(page).not_to have_content(include(cell))
  end

  it 'Редактирование номера сотового телефона' do
    visit('/')
    cell = find_by_id('cell', match: :first).text
    visit('/edit_cell/0')
    expect(page).to have_content(cell)
    fill_in('cell', with: '99999')
    click_on('Изменить')
    expect(page).to have_content('99999')
  end

  it 'Неверное редактирование номера сотового телефона' do
    visit('/edit_cell/0')
    click_on('Изменить')
    expect(page).to have_content('В этом поле должно быть число >0')
  end

  it 'Редактирование номера домашнего телефона' do
    visit('/')
    home = find_by_id('home', match: :first).text
    visit('/edit_home/0')
    expect(page).to have_content(home)
    fill_in('home', with: '88888')
    click_on('Изменить')
    expect(page).to have_content('88888')
  end

  it 'Неверное редактирование номера домашнего телефона' do
    visit('/edit_home/0')
    click_on('Изменить')
    expect(page).to have_content('В этом поле должно быть число >0')
  end

  it 'Редактирование статуса' do
    visit('/')
    status = find_by_id('status', match: :first).text
    visit('/edit_status/0')
    expect(page).to have_content(status)
    select('Коллега', from: 'status')
    click_on('Изменить')
    expect(page).to have_content('Коллега')
  end

  it 'Редактирование адреса' do
    visit('/')
    address = find_by_id('address', match: :first).text
    visit('/edit_address/0')
    expect(page).to have_content(address)
    fill_in('street', with: 'molod')
    fill_in('house', with: '123')
    click_on('Изменить')
    expect(page).to have_content('molod 123')
  end

  it 'Неправильное редактирование адреса' do
    visit('/edit_address/0')
    click_on('Изменить')
    expect(page).to have_content('Это поле не должно быть пустым')
    expect(page).to have_content('В этом поле должно быть число >0')
  end

  it 'Тест отправки поздравлений' do
    visit('/event')
    select('Коллега', from: 'status')
    fill_in('event', with: 'День рождения')
    fill_in('mes', with: 'Привет')
    click_on('Отправить')
  end

  it 'Негативный тест отправки поздравлений' do
    visit('/event')
    click_on('Отправить')
    expect(page).to have_content('Не должно быть пустой строки')
  end



  it 'Тест на добавление счёта' do
    visit('/add_person')
    fill_in('surname', with: 'SURNAME_ABC_DEF')
    fill_in('name', with: 'NAME_ABC_DEF')
    fill_in('m_name', with: 'PATR_ABC_DEF')
    fill_in('house', with: '1')
    fill_in('street', with: 'STREET_NEW')
    fill_in('cell', with: '12345')
    fill_in('home', with: '98765')
    select('Женский', from: 'gender')
    select('5', from: 'month')
    select('5', from: 'day')
    fill_in('year', with: '1999')
    select('Друг', from: 'status')
    click_on('Добавить')
  end



end
