require_relative 'person'
require_relative 'address'
require_relative 'utility_bill'
require_relative 'utility_bill_data_base'



module Command
    def self.general_bill(name,surname,patronymic,type,data_base)
        solo_data_base = []
        data_base.each_with_index do |ut_bill,index|
            if ut_bill.fio.surname==surname && ut_bill.fio.name==name && ut_bill.fio.patronymic==patronymic && ut_bill.type==type
                solo_data_base << ut_bill
            end
        end
        solo_data_base.each do |elm|
            data_base.remove(data_base.index(elm)+1)
        end
        solo_bill=solo_data_base[0]
        solo_data_base.each_with_index do |ut_bill,index|
            next if index == 0
            solo_bill.paid += ut_bill.paid
            solo_bill.pay_am = solo_bill.pay_am.to_i + ut_bill.pay_am.to_i
            solo_bill.month = ut_bill.month if ut_bill.month.to_i>solo_bill.month.to_i 
        end
        solo_bill
    end 
end