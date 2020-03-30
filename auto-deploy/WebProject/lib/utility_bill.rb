# frozen_string_literal: true

# This is the main class denoting the essence, the utility bill
class UtilityBills
  attr_accessor :fio, :address, :pay_am, :paid, :type, :month, :errors
  def initialize(fio, address, pay_am, type, month)
    @fio = fio
    @address = address
    @month = month
    @pay_am = pay_am
    @paid = 0
    @type = type
    @errors = {}
  end

  def check_error
    void
    negative
  end

  def void
    if @fio.check_space ||
       @address.city.empty? || @address.street.empty? || @address.house.empty? ||
       @pay_am.empty?
      @errors[:space] = 'Это поле не должно быть пустым!'
    end
  end

  def negative
    zero = true if @address.house.to_i <= 0 || @address.apartment.to_i <= 0 || @pay_am.to_i <= 0
    @errors[:negative] = 'В этом поле должно быть положительное число!' if zero
  end
end
