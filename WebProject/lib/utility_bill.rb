
#payment_amount - сумма платежа
#paid - проплаченный
class UtilityBills
  attr_accessor :fio,:address,:payment_amount,:paid,:type,:month
  def initialize(fio,address,payment_amount,type,month)
    @fio=fio
    @address=address
    @month=month
    @payment_amount=payment_amount
    @paid=0
    @type=type
  end

  def to_s
    "\n#{@fio}\nAddress:#{@address}\nPayment month:#{@month}\nType paymant:#{"#{@type}"}\nPayment amount:#{@payment_amount}\nPaid:#{@paid}"
  end

end