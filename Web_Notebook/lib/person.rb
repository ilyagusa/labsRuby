# frozen_string_literal: true

# stores info about one person
class Person
  attr_reader :name, :surname, :m_name, :sex_person, :date, :cell_phone,
              :home_phone, :address, :status
  attr_writer :cell_phone, :address, :status, :home_phone

  def initialize(name, surname, m_name, sex_person, date, cell_phone,
                 home_phone, address, status)
    @name = name
    @surname = surname
    @m_name = m_name
    @sex_person = sex_person
    @date = date
    @cell_phone = cell_phone
    @home_phone = home_phone
    @address = address
    @status = status
    @errors = {}
  end

  def ==(other)
    @name == other.name &&
      @surname == other.surname &&
      @m_name == other.m_name &&
      @sex_person == other.sex_person &&
      @date == other.date
  end

  def check_error
    @errors[:negative_cell] = 'Обычно номер телефона больше чем ноль'  if @cell_phone.to_i <= 0 || @cell_phone.empty?
    @errors[:negative_home] = 'Обычно номер телефона больше чем ноль'  if @home_phone.to_i <= 0 || @home_phone.empty?
    check_other_error
    @errors
  end

  def check_other_error
    @errors[:space_name] = 'Это поле не должно быть пустым' if @name.empty?
    @errors[:space_surname] = 'Это поле не должно быть пустым' if @surname.empty?
    @errors[:space_patronymic] = 'Это поле не должно быть пустым' if @m_name.empty?
  end

  def to_s
    str = "\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@m_name}\nПол:#{@sex_person} \nДата рождения:#{@date}" \
          "\nМобильный номер: #{@cell_phone}\nДомашний номер: #{@home_phone}" \
          "\nАдрес: #{@address}\nСтатус: #{@status}"
    str
  end
end
