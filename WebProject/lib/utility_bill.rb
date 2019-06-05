# frozen_string_literal: true

# pay_am - summa platezha
# paid - skolko_proplacheno
class UtilityBills
  attr_accessor :fio, :address, :pay_am, :paid, :type, :month
  def initialize(fio, address, pay_am, type, month)
    @fio = fio
    @address = address
    @month = month
    @pay_am = pay_am
    @paid = 0
    @type = type
  end

  def to_s
    "\n#{@fio}\nAddress:#{@address}\nPayment month:#{@month}\nType paymant:#{@type}\nPay am:#{@pay_am}\nPaid:#{@paid}"
  end
end
