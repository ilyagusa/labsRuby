require_relative '../../input'
polinom=Array.new
puts "Введите коэффициенты полинома,где первое введенное число коэффициент при максимальной степени полинома"
loop do
    current=input_number
    break  if current.nil?
    polinom<<Integer(current)
end

def printed(polinom1)
    size=(polinom1.size-1)
    for value in polinom1 do
        if (size>=1)
            print"#{value}*x^#{size}"
            print "+"
            size-=1
        else 
            print "#{value}"
        end
    end
end
printed(polinom)

def calculation(polinom1)
    print"Введите точку в которой программа  посчитает полином >"
    a=input_number
    size=polinom1.size
    sum=0
    for value in polinom1 do
        temp=Integer(a**(size-1))
        sum+=temp*value
        break if size==0
        size-=1
    end
    return sum
end
puts "calc=#{calculation(polinom)}"


def derivative(polinom1)
    print"Введите точку в которой программа  посчитает  производную полинома >"
    a=input_number
    size=polinom1.size
    sum=0
    for value in polinom1 do
        temp=Integer(a**(size-2))
        sum+=temp*value*(size-1)
        break if size==0
        size-=1
    end
    return sum 
end

puts "derivative=#{derivative(polinom)}"