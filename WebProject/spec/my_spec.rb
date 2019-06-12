# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Should provide text when connecting to /' do
    visit('/')
    expect(page).to have_content('Работа с коммунальными платежами')
  end

  it 'Проверка контента при переходе к show_utb' do
    visit('/show_utb')
    expect(page).to have_content('Работа с коммунальными платежами')
  end

  it 'Тест на добавление счёта' do
    visit('/')
    click_on('Добавить счёт')
    fill_in('surname', with: 'NAME_ABC_DEF')
    fill_in('name', with: 'SURNAME_ABC_DEF')
    fill_in('patronymic', with: 'PATR_ABC_DEF')
    fill_in('city', with: 'CITY_NEW')
    fill_in('street', with: 'STREET_NEW')
    fill_in('house', with: '12345')
    fill_in('apartment', with: '98765')
    select('5', from: 'month')
    select('Квартплата', from: 'type')
    fill_in('pay_am', with: '513762')
    click_on('Добавить')
    expect(page).to have_content('NAME_ABC_DEF')
    expect(page).to have_content('SURNAME_ABC_DEF')
    expect(page).to have_content('PATR_ABC_DEF')
    expect(page).to have_content('CITY_NEW')
    expect(page).to have_content('STREET_NEW')
    expect(page).to have_content('12345')
    expect(page).to have_content('98765')
    expect(page).to have_content('5')
    expect(page).to have_content('Квартплата')
    expect(page).to have_content('513762')
  end

  it 'Негативный тест на добавление' do
    visit('/')
    click_on('Добавить счёт')
    expect(page).to have_content('Добавление счёта в общий список')
    click_on('Добавить')
    expect(page).to have_content('В этом поле должно быть положительное число!')
    expect(page).to have_content('Это поле не должно быть пустым!')
  end

  it 'Тест на оплату' do
    visit('/')
    paid = find_by_id('paid', match: :first).text
    click_on('Оплатить счёт', id: 'pay-mark-0')
    expect(page).to have_content('Подробный запрос на оплату')
    fill_in('paid', with: '1')
    click_on('Оплатить')
    expect(page).to have_content(paid.to_i + 1)
  end

  it 'Тест на оплату негативный' do
    visit('/')
    click_on('Оплатить счёт', id: 'pay-mark-0')
    click_on('Оплатить')
    expect(page).to have_content('Ошибка ввода!')
  end

  it 'Тест статистики' do
    visit('/')
    click_on('Статистика')
    expect(page).to have_content('Статистика')
  end

  it 'Тест на вывод всех счетов человека' do
    visit('/')
    click_on('Вывести все счета человека')
    fill_in('surname', with: 'NAME_ABC_DEF')
    fill_in('name', with: 'SURNAME_ABC_DEF')
    fill_in('patronymic', with: 'PATR_ABC_DEF')
    click_on('Показать все счета')
    expect(page).to have_content('NAME_ABC_DEF')
    expect(page).to have_content('SURNAME_ABC_DEF')
    expect(page).to have_content('PATR_ABC_DEF')
    expect(page).to have_content('CITY_NEW')
    expect(page).to have_content('STREET_NEW')
    expect(page).to have_content('12345')
    expect(page).to have_content('98765')
    expect(page).to have_content('5')
    expect(page).to have_content('Квартплата')
    expect(page).to have_content('513762')
  end

  it 'Негативный тест на вывод всех счетов человека' do
    visit('/')
    click_on('Вывести все счета человека')
    click_on('Показать все счета')
    expect(page).to have_content('Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)')
  end

  it 'Тест группировки по типу' do
    visit('/')
    click_on('Группировка счетов по типу')
    expect(page).to have_content('Группировка счетов для выбраного человека по типу счёта')
    fill_in('surname', with: 'NAME_ABC_DEF')
    fill_in('name', with: 'SURNAME_ABC_DEF')
    fill_in('patronymic', with: 'PATR_ABC_DEF')
    click_on('Показать счета')
    expect(page).to have_content('NAME_ABC_DEF')
    expect(page).to have_content('SURNAME_ABC_DEF')
    expect(page).to have_content('PATR_ABC_DEF')
    expect(page).to have_content('CITY_NEW')
    expect(page).to have_content('STREET_NEW')
    expect(page).to have_content('12345')
    expect(page).to have_content('98765')
    expect(page).to have_content('5')
    expect(page).to have_content('Квартплата')
    expect(page).to have_content('513762')
  end

  it 'Негативный тест группировки по типу' do
    visit('/')
    click_on('Группировка счетов по типу')
    click_on('Показать счета')
    expect(page).to have_content('Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)')
  end

  it 'Тест списка должников' do
    visit('/')
    click_on('Список должников')
    expect(page).to have_content('Список должников')
  end

  it 'Тест объединения счетов по типу' do
    visit('/')
    click_on('Добавить счёт')
    fill_in('surname', with: 'NAME_ABC_DEF')
    fill_in('name', with: 'SURNAME_ABC_DEF')
    fill_in('patronymic', with: 'PATR_ABC_DEF')
    fill_in('city', with: 'CITY_NEW')
    fill_in('street', with: 'STREET_NEW')
    fill_in('house', with: '12345')
    fill_in('apartment', with: '67821')
    select('12', from: 'month')
    select('Квартплата', from: 'type')
    fill_in('pay_am', with: '1000')
    click_on('Добавить')
    click_on('Общий счёт для человека')
    fill_in('surname', with: 'NAME_ABC_DEF')
    fill_in('name', with: 'SURNAME_ABC_DEF')
    fill_in('pat', with: 'PATR_ABC_DEF')
    select('Квартплата', from: 'type')
    click_on('Объединить счета')
    expect(page).to have_content('Общий счёт')
  end

  it 'Негативный тест на объединение счетов' do
    visit('/')
    click_on('Общий счёт для человека')
    click_on('Объединить счета')
    expect(page).to have_content('Не найдено ни одного счёта(Квартплата) для данного человека')
  end

  it 'Тест на невыставленные счета' do
    visit('/')
    click_on('Невыставленные счета')
    select('6', from: 'month')
    select('Плата за телефон', from: 'type')
    click_on('Показать людей которым не выстален счёт')
    expect(page).to have_content('Список людей которым не выставлен счёт')
  end

  it 'Негативный тест на невыставленные счета' do
    visit('/')
    click_on('Невыставленные счета')
    select('Квартплата', from: 'type')
    select('12', from: 'month')
    click_on('Показать людей которым не выстален счёт')
    expect(page).not_to have_content('NAME_ABC_DEF')
  end

  it 'Тест на удаление' do
    visit('/')
    name = find_by_id('name', match: :first).text
    surname = find_by_id('surname', match: :first).text
    patronymic = find_by_id('patronymic', match: :first).text
    month = find_by_id('month', match: :first).text
    type = find_by_id('type', match: :first).text
    pay_am = find_by_id('pay_am', match: :first).text
    paid = find_by_id('paid', match: :first).text
    click_on('Удалить счёт')
    fill_in('index', with: '1')
    click_on('Удалить')
    expect(page).not_to have_content(include(name).and(include(surname).and(include(patronymic)
    .and(include(month).and(include(type)
    .and(include(pay_am).and(include(paid))))))))
  end

  it 'Негативный тест на удаление' do
    visit('/')
    click_on('Удалить счёт')
    click_on('Удалить')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера счёта')
  end
end
