def chekName(nameSurn,exp)
        if ((nameSurn.chomp()=="Petr Petrovich") && (exp>5 && exp<15) )
                puts "Профессия:Заслуженный Руководитель"
        elsif ((nameSurn.chomp()=="Petr Petrovich") && exp>15)
                puts "Профессия:Известный Руководитель"
        elsif((nameSurn.chomp()=="Petr Petrovich") && exp.to_i<=5)  
                puts "Профессия:Руководитель"
        else 
                return puts "debil"
               exit
        end
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

    chekName(NameAndSurname,Expirience)
