def read_real
    numb=gets
    return nil if numb.nil?
    return Float(numb)
    rescue ArgumentError => _exception
    puts "error"
end

def checknum(num)
    if ( num> 0 ) 
    puts "positive num"
    elsif (num < 0 )  
    puts "negative num"
    else 
    puts "unknown num"
    end
end
	
print "Enter num>"
    checknum(read_real)
	