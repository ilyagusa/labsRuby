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
    return age
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