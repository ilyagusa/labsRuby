# frozen_string_literal: true

require_relative 'notebook'
require_relative 'input'
require_relative 'person'

module Notebook
  # 1
  class Core
    def initialize
      @options = { 'remove' => :remove, 'add' => :add, 'address' => :ch_address, 'status' => :ch_status,
                   'phone' => :ch_phone,
                   'event' => :event, 'exit' => :exit, 'show' => :show }
      @notebook = Input.read_file
      help
    end

    def run
      loop do
        line = Input.string_input('> ')

        method = @options[line.strip]

        if method.nil?
          puts 'Неизвестная команда, попробуйте снова'
          next
        end

        # call given method
        send(method)
      end
    end

    private

    def add
      name = Input.string_input('Имя: ')
      surname = Input.string_input('Фамилия: ')
      m_name = Input.string_input('Отчество: ')
      sex_person = Input.string_input('Пол:')
      date = Input.string_input('Дата рождения:')
      cell_phone = Input.phone_input('Мобильный номер: ')
      home_phone = Input.phone_input('Домашний номер: ')
      address = Input.string_input('Адрес(<Улица> <Номер дома>): ')
      status = Input.string_input('Статус: ')

      person = Person.new(name, surname, m_name, sex_person, date, cell_phone, home_phone, address, status)
      @notebook.add(person)
    end

    def remove
      show_short
      index = Input.num_input('Номер человека в записной книжке: ')

      @notebook.remove(index)
    end

    def ch_address
      show_short
      index = Input.num_input('Номер человека в записной книжке: ')

      new_address = Input.string_input('Новый адрес(<Улица> <Номер дома>): ')
      @notebook.change_address(index, new_address)
    end

    def ch_phone
      show_short
      index = Input.num_input('Номер человека в записной книжке: ')

      new_phone = Input.phone_input('Новый номер телефона: ')
      @notebook.change_phone(index, new_phone)
    end

    def ch_status
      show_short
      index = Input.num_input('Номер человека в записной книжке: ')

      new_stastus = Input.string_input('Новый статус человека')
      @notebook.change_status(index, new_stastus)
    end

    # def sc_data
    # end

    def event
      event = Input.string_input('Название приглашения: ')
      status = Input.string_input('Приглашение по статусу: ')

      invited = @notebook.event(status)
      invited.each do |person|
        file_wr(person, event)
      end
    end

    def file_wr(person, event)
      message = ''
      name = "#{person.surname} #{person.name} #{person.m_name}"
      file = File.new(name, 'w')

      message += "#{event}\n"
      message += "#{person.address}\n" if Input.string_input('Добавить адрес[y/n]?: ').casecmp?('y')

      message += "#{name}\n" + Input.string_input('Сообщение: ')

      file.write(message)
      file.close
    end

    def show
      @notebook.each { |person| puts person }
    end

    def show_short
      @notebook.each_with_index do |person, index|
        puts "#{index + 1}. #{person.surname} #{person.name} #{person.m_name}"
      end
    end

    def help
      help =
        {
          show: 'Показать всех',
          add: 'Добавить нового человека в записную книжку',
          remove: 'Удалить человека из записной книжки',
          address: 'Изменить адрес у выбранного человека',
          status: 'Изменить статус у выбранного человека',
          phone: 'Изменить номер у выбранного человека',
          event: 'Создать приглашение',
          exit: 'Выйти из программы'
        }
      help.each { |key, value| puts "#{key} - #{value}" }
    end
  end
end
