def chekProfession(nameSurn,expstr,mail,strage)
        str=""
        str+=expstr.to_s
        str+=strage.to_s
        if (nameSurn.chomp()=="Petr Petrovich")
                str+=" Руководитель"
        end
        if mail.include? "code"
                str+=" Инженер"
        end
        return str
end

def chekExp(exp)
        str=""
        if exp>5 && exp<=15
                str="Заслуженный"
        elsif exp>15 
                str="Известный"
        elsif exp<2
                str="Стажёр"
        end
        return str
end

def chekAge(age)
        str=""
        if ((age>=45) && (age<=60))
                str="Бывалый"
        end
        return str
end



def getStr()
        str=gets
        if str==nil
            return nil
            exit
    else return str
    end
end
    
def getAge()
        age=gets
        return nil if age.nil?
        age=Integer(age)
        if  age >= 15 and age <= 100
         age
        else 
        print "invalid Age"
        exit
        end
end
    
    
    def getExp()
        exp=gets
        return nil if exp.nil?
        exp=Integer(exp)
        if exp>0  
        return Integer(exp)
        else
        puts "invalid expirience"
        exit
        end
    end
    
    
    
    print "Enter name and surname>"
    NameAndSurname=getStr()
    puts "Name and Surname:#{NameAndSurname.chomp}"
    print "Enter your mail>"
    Mail=getStr()
    puts "Mail:#{Mail.chomp}"
    print "Enter your age>"
    Age=getAge()
    puts "Age:#{Age}"
    print "Enter your work exp>"
    Expirience=getExp()
    puts "Exp:#{Expirience}"


    a=chekExp(Expirience)
    b=chekAge(Age)
  puts "PROFESSION :::#{ chekProfession(NameAndSurname,a,Mail,b)}"
