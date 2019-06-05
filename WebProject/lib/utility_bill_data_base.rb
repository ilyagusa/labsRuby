require_relative 'utility_bill'

class UtilityBillDataBase

    def initialize  (utility_bill_data_base = [])
        @utility_bill_data_base = utility_bill_data_base
    end

    def add(utility_bill)
        @utility_bill_data_base.push(utility_bill)
    end
    
      def utility_bill(index)
        @utility_bill_data_base[index]
      end
    
      def size
        @utility_bill_data_base.size
      end
    
      #def sort
       # @tourist_db.sort_by { |tourist| tourist.fio.surname }
      #end
    
      def remove(index)
        @utility_bill_data_base.delete_at(index)
      end
    
      def each_with_index
        @utility_bill_data_base.each_with_index { |ut_bill, index| yield(ut_bill, index) }
      end

      def each
        @utility_bill_data_base.each  { |ut_bill| yield(ut_bill) }
      end
    
end