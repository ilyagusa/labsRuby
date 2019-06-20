# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Проверка контента при переходе к show_utb' do
    visit('/show_utb')
    expect(page).to have_content('Работа с коммунальными платежами')
  end

  it 'Тест на добавление счёта и объединение счетов' do
    visit('/')
    name = find_by_id('name', match: :first).text.gsub('Имя: ', '').strip
    surname = find_by_id('surname', match: :first).text.gsub('Фамилия: ', '').strip
    patronymic = find_by_id('patronymic', match: :first).text.gsub('Отчество: ', '').strip
    month = find_by_id('month', match: :first).text.gsub('Месяц платежа: ', '').strip
    type = find_by_id('type', match: :first).text.gsub('Тип счёта: ', '').strip
    click_on('Добавить счёт')
    fill_in('surname', with: surname)
    fill_in('name', with: name)
    fill_in('patronymic', with: patronymic)
    fill_in('city', with: 'CITY_NEW')
    fill_in('street', with: 'STREET_NEW')
    fill_in('house', with: '12345')
    fill_in('apartment', with: '98765')
    select(month.to_i, from: 'month')
    select(type, from: 'type')
    fill_in('pay_am', with: '7897')
    click_on('Добавить')
    click_on('Общий счёт для человека')
    fill_in('surname', with: surname)
    fill_in('name', with: name)
    fill_in('pat', with: patronymic)
    select(type, from: 'type')
    click_on('Объединить счета')
    expect(page).to have_content('Общий счёт')
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
    name = find_by_id('name', match: :first).text.gsub('Имя: ', '')
    surname = find_by_id('surname', match: :first).text.gsub('Фамилия: ', '')
    patronymic = find_by_id('patronymic', match: :first).text.gsub('Отчество: ', '')
    click_on('Вывести все счета человека')
    fill_in('name', with: name)
    fill_in('surname', with: surname)
    fill_in('patronymic'.to_s, with: patronymic)
    click_on('Показать все счета')
    expect(page).to have_content(surname)
    expect(page).to have_content(name)
    expect(page).to have_content(patronymic)
  end

  it 'Негативный тест на вывод всех счетов человека' do
    visit('/')
    click_on('Вывести все счета человека')
    click_on('Показать все счета')
    expect(page).to have_content('Не найдено ни одного счёта для этого человека(Все поля должны быть заполнены!!!)')
  end

  it 'Тест группировки по типу' do
    visit('/')
    name = find_by_id('name', match: :first).text.gsub('Имя: ', '')
    surname = find_by_id('surname', match: :first).text.gsub('Фамилия: ', '')
    patronymic = find_by_id('patronymic', match: :first).text.gsub('Отчество: ', '')
    type = find_by_id('type', match: :first).text
    click_on('Группировка счетов по типу')
    expect(page).to have_content('Группировка счетов для выбраного человека по типу счёта')
    fill_in('surname', with: surname)
    fill_in('name', with: name)
    fill_in('patronymic', with: patronymic)
    click_on('Показать счета')
    expect(page).to have_content(name)
    expect(page).to have_content(surname)
    expect(page).to have_content(patronymic)
    expect(page).to have_content(type)
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

  it 'Тест на невыставленные счета' do
    visit('/')
    name = find_by_id('name', match: :first).text.gsub('Имя: ', '')
    surname = find_by_id('surname', match: :first).text.gsub('Фамилия: ', '')
    patronymic = find_by_id('patronymic', match: :first).text.gsub('Отчество: ', '')
    month = find_by_id('month', match: :first).text.gsub('Месяц платежа: ', '')
    type = find_by_id('type', match: :first).text.gsub('Тип счёта: ', '')
    click_on('Невыставленные счета')
    select(month.to_i, from: 'month')
    select(type, from: 'type')
    click_on('Показать людей которым не выстален счёт')
    expect(page).to have_content('Список людей которым не выставлен счёт')
    expect(page).not_to have_content(include(name).and(include(surname).and(include(patronymic)
    .and(include(month).and(include(type))))))
  end

  it 'Негативный тест на объединение счетов' do
    visit('/')
    click_on('Общий счёт для человека')
    click_on('Объединить счета')
    expect(page).to have_content('Не найдено ни одного счёта(Квартплата) для данного человека')
  end

  it 'Негативный тест на невыставленные счета' do
    visit('/')
    click_on('Невыставленные счета')
    select('Квартплата', from: 'type')
    select('12', from: 'month')
    click_on('Показать людей которым не выстален счёт')
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

  it 'Тест на добавление уже имеющегося элемента' do
    visit('/')
    (0..1).each do |_i|
      click_on('Добавить счёт')
      fill_in('surname', with: 'SURNAME_ABC_DEF')
      fill_in('name', with: 'NAME_ABC_DEF')
      fill_in('patronymic', with: 'PATR_ABC_DEF')
      fill_in('city', with: 'CITY_NEW')
      fill_in('street', with: 'STREET_NEW')
      fill_in('house', with: '12345')
      fill_in('apartment', with: '98765')
      select('5', from: 'month')
      select('Квартплата', from: 'type')
      fill_in('pay_am', with: '513762')
      click_on('Добавить')
    end
  end
end
