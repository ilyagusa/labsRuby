# frozen_string_literal: true

require_relative 'notebook'
require_relative 'input'
require_relative 'person'

# 1
module Commands
  def self.event(notebook, event, status, mes)
    file_inv = File.new('Список приглашенных', 'w')
    invited = notebook.event(status)
    invited.each do |person|
      fio = "#{person.name} #{person.surname} #{person.m_name} \n"
      puts fio
      file_inv.write(fio)
      file_wr(person, event, mes)
    end
    file_inv.close
  end

  def self.file_wr(person, event, mes)
    message = ''
    name = "#{person.surname} #{person.name} #{person.m_name}"
    file = File.new(name, 'w')
    message += "#{name} ,Вы приглашены на #{event}\n"
    message += mes
    file.write(message)
    file.close
  end
end
