# frozen_string_literal: true

require_relative 'notebook'
require_relative 'person'
require 'psych'

# Input methods
module Input
  DATA_FILE = File.expand_path('../data/base.yaml', __dir__)

  # to print message use message w/out '\n'
  def self.num_input(message)
    loop do
      print message.to_s
      line = gets

      return nil if line.nil?

      return Float(line.strip)
    rescue ArgumentError => _e
      puts 'Неправильный ввод, повторите попытку'
    end
  end

  def self.string_input(message)
    loop do
      print message.to_s
      line = gets

      if line.nil?
        puts 'Это поле не может быть пустым!'
        next
      end
      line = line.strip
      if line.empty?
        puts 'Это поле не может быть пустым!'
        next
      end
      return line
    end
  end

  def self.phone_input(message)
    loop do
      line = string_input(message)
      # delete all spaces in the string
      line.gsub!(/\s+/, '')

      # parse only valid phone numbers
      # (+ or NUMBER)NUMBERS

      return line if line.match?(/^([+]|\d)\d+$/)

      puts 'Номер введен неправильно'
    end
  end

  def self.read_file
    notebook = Notebook.new
    exit unless File.exist?(DATA_FILE)
    all_info = Psych.load_file(DATA_FILE)
    all_info.each do |person|
      pers = Person.new(person['name'], person['surname'], person['patr'], person['sex person'],
                        person['date'], person['cell ph'], person['home ph'], person['address'], person['status'])
      notebook.add(pers)
    end
    notebook
  end

  def self.save(notebook)
    # p Psych.dump(notebook)
    # File.open(DATA_FILE, 'w') do |file|
    #  file.write(Psych.dump(notebook))
    # end
  end
end
