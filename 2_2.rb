def read_real
    numb=gets
    return nil if numb.nil?
    return Float(numb)
    rescue ArgumentError => _exception
    puts "error"
end

def checknum(num)
    if ( num> 0 ) 
    puts "Your capital=#{num}"
    return true
    else  
    puts "negative capital - error"
    return false
    end
end

def choice()
    puts "Enter your choice(Yes or No)"
    yourchoice=gets
    if yourchoice.chomp=="Yes" 
        return true
    elsif yourchoice.chomp=="No"
        return false
    else 
        puts "error"
        exit
    end
end

def game(summa)
    randnum=rand(15)
    puts randnum
    case randnum
    when 0..5
         summa=(summa*0.5)
    when 6..7   
          summa=(summa*0.9)
    when 8..9
           summa=(summa*0.98)
    when 10..11
         summa
    when 12..13
         summa=(summa*1.02)
    when 14..15
        summa=(summa*1.1)
    end
end
    

print "Enter start capital>"
sum=read_real
if (checknum(sum))
while(choice())   
    sum=game(sum)
    puts "Your up capital =#{sum}"
end
puts "Your final score=#{sum}"
end

