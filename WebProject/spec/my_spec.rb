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

  it  'Проверка контента при переходе к show_utb' do
    visit('/show_utb')
    expect(page).to have_content('Работа с коммунальными платежами')
  end

  it 'Тест на добавление счёта' do
    visit('/')
    click
  end

end