# frozen_string_literal: true

require_relative 'notebook'
require_relative 'person'
require 'psych'

# Input methods
module Input
  DATA_FILE = File.expand_path('../data/base.yaml', __dir__)

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
end
