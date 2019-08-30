# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Тест на вывод всех счетов человека' do
    visit('/')
    click_on('Вывести все счета человека')
    name = find_by_id('name', match: :first).text
    surname = find_by_id('surname', match: :first).text
    patronymic = find_by_id('patronymic', match: :first).text
    fill_in('surname', with: name)
    fill_in('name', with: surname)
    fill_in('patronymic', with: patronymic)
    click_on('Показать все счета')
    expect(page).to have_content(name)
    expect(page).to have_content(surname)
    expect(page).to have_content(patronymic)
  end
end
